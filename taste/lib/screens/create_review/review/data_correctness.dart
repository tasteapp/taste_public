import 'package:flutter/material.dart';
import '../../../utils/extensions.dart';

enum PostVariable {
  delivery,
  contestRestaurant,
  homeCooking,
  contestHomeCooking,
  restaurant,
}

enum RelationType {
  implies,
  exclusive,
}

extension on PostVariable {
  Implication implies(PostVariable variable) =>
      Implication(this, RelationType.implies, variable);
  Implication exclusiveWith(PostVariable boolVar) =>
      Implication(this, RelationType.exclusive, boolVar);
}

@immutable
class Implication {
  const Implication(this.subject, this.relation, this.object);
  final PostVariable subject;
  final RelationType relation;
  final PostVariable object;
}

final _baseImplications = [
  PostVariable.restaurant.exclusiveWith(PostVariable.homeCooking),
  PostVariable.contestRestaurant.implies(PostVariable.restaurant),
  PostVariable.contestHomeCooking.implies(PostVariable.homeCooking),
  PostVariable.delivery.implies(PostVariable.restaurant),
];

final _implicationLookup = (() {
  // Nested map containing direct implications.
  // subject -> subject value -> object -> object's implied value.
  // Seed it with the identity law:
  //  A ->  A
  // !A -> !A
  final storage = PostVariable.values
      .toMap((variable) => [true, false].toMap((value) => {variable: value}));
  // Stores the relation in `storage` and returns whether the relation is new.
  // Throws exception when conditions are unsolvable.
  bool didUpdate(PostVariable subject, bool subjectValue, PostVariable object,
      bool objectValue) {
    final objectMap = storage[subject][subjectValue];
    final existing = objectMap[object];
    if (existing == null) {
      // Never seen before, this is a new relation.
      objectMap[object] = objectValue;
      return true;
    }
    if (existing != objectValue) {
      // The supplied base implications are contradictory.
      throw Exception('unsolvable');
    }
    // We already saw this relation before, no update.
    return false;
  }

  // Store the direct boolean conditions implied by the base relations.
  _baseImplications.forEach((i) {
    switch (i.relation) {
      case RelationType.exclusive:
        // Exclusivity implies two distinct conditions.
        didUpdate(i.subject, true, i.object, false);
        didUpdate(i.subject, false, i.object, true);
        break;
      case RelationType.implies:
        // While a simple implies only creates one condition.
        didUpdate(i.subject, true, i.object, true);
        break;
    }
  });
  // Add the "transposition" rules.
  // A -> B implies !B -> !A
  // https://en.wikipedia.org/wiki/Transposition_(logic)
  storage.entries.toList().forEach((a) => a.value.entries.toList().forEach(
      (pA) => pA.value.entries
          .toList()
          .forEach((b) => didUpdate(b.key, !b.value, a.key, !pA.key))));

  // Iteratively apply the transitive law
  // A -> B -> C implies A -> C
  // https://www.britannica.com/topic/transitive-law

  // `didUpdate` allows us to check termination conditions since it returns true
  // only when a new relation is discovered.
  // Thus we apply a cascade of `expand` calls to capture at least 1 update to
  // cause the loop to start again.
  while (storage.any((subject, values) => values.any((subjectValue, objects) =>
      objects.any((object, value) => storage[object][value].any(
          (child, childValue) =>
              didUpdate(subject, subjectValue, child, childValue)))))) {}
  return storage;
})();

Map<PostVariable, bool> getImplications(Map<PostVariable, bool> conditions) =>
    Map.fromEntries(conditions.entries
        .expand((entry) => _implicationLookup[entry.key][entry.value].entries));
