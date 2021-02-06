import 'utilities.dart';

void main() {
  group('review-tags', () {
    setUp(setupEmulator);
    tearDown(tearDownEmulator);
    test('review-tags', () async {
      expect(
          (await Fixture().createReview(
                  attributes: {'space   Attribute  ', 'cool'},
                  text: '#yes I am adding # asdf#cool tags #atend',
                  emojis: {'#veggie', 'notatag', '🇺🇸', '😃'}))
              .tags,
          {'cool', 'yes', 'atend', 'veggie', 'space-attribute', '🇺🇸'});
    });
  });
}
