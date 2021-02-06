import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

import 'register_type.dart';

class FirestoreProtoGenerator extends GeneratorForAnnotation<RegisterType> {
  static const superClass = 'FirestoreProto';
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = element as ClassElement;
    final className = classElement.name;
    final interfaces = [
      classElement.mixins,
      classElement.interfaces,
      classElement.superclassConstraints
    ].expand((i) => i).map((i) => i.name).toSet()
      ..remove(superClass)
      ..remove('Object');
    final protoNameSuffix = classElement.superclassConstraints
        .firstWhere((c) => c.name == superClass)
        .typeArguments
        .first
        .name;
    final protoName = '\$pb.$protoNameSuffix';
    final newClassName = '${className}s';
    final collectionName = annotation.peek('type')?.read('name')?.stringValue ??
        '${ReCase(protoNameSuffix).snakeCase}s';

    final triggersString = classElement.getField('triggers') == null
        ? ''
        : '$className.triggers(collectionType, make);';
    final registerString = classElement.getMethod('registerInternal') == null
        ? ''
        : '$className.registerInternal();';
    return """
class $newClassName extends $superClass<$protoName>
    with ${interfaces.followedBy([className]).join(', ')} {
  static $protoName get emptyInstance => $protoName();
  static final collectionType = CollectionType.$collectionName;
  static final collection = collectionType.coll;
  $newClassName(DocumentSnapshot snapshot, BatchedTransaction transaction,
      [bool checkExists = true])
      : super(snapshot, transaction, CollectionType.$collectionName,
            checkExists: checkExists);

  static Future<$className> fromPath(String path, [BatchedTransaction transaction]) async {
    transaction ??= quickTrans;
    final snapshot = await path.ref.tGet(transaction);
    return make(snapshot, transaction);
  } 

  static $className make(
          DocumentSnapshot snapshot, BatchedTransaction transaction,
          [bool checkExists = true]) =>
      $newClassName(snapshot, transaction, checkExists);
  static $className makeSimple(DocumentData data, DocumentReference reference,
          BatchedTransaction transaction,
          [bool checkExists = true]) =>
      make(SimpleSnapshot(data, reference), transaction, checkExists);

  static Future<$className> forRef(
          DocumentReference ref, BatchedTransaction trans) async =>
      make(await ref.tGet(trans), trans);
  
  static Future<$className> createNew(BatchedTransaction transaction,
      {DocumentData data, String documentId}) async {
    data ??= DocumentData();
    return makeSimple(
        data,
        await transaction.create(collection.document(documentId), data),
        transaction);
  }

  @override
  $protoName get prototype => emptyInstance;

  static Future<List<$className>> get(
          {BatchedTransaction trans,
          DocumentQuery Function(DocumentQuery query) queryFn}) async =>
      SnapshotHolder.wrapQueryStatic((queryFn ?? (i) => i)(collection),
          trans ?? await autoBatch((t) => t), make);

  static void register() {
    $registerString
    $triggersString
  }

  @override
  Future<$className> get refetchInternal async =>
      make(await transaction.get(ref), transaction);
}

extension ${className}Extension on $className {
  Future<$className> get refetch async => (await refetchInternal) as $className;
}
""";
  }
}

class TasteRequestGenerator extends GeneratorForAnnotation<TasteRequest> {
  static const superClass = 'CallRequest';
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = element as ClassElement;
    final className = classElement.name;
    final interfaces = [
      classElement.mixins,
      classElement.interfaces,
      classElement.superclassConstraints
    ].expand((i) => i).map((i) => i.name).toSet()
      ..remove(superClass)
      ..remove('Object');
    final protoNameSuffix = classElement.superclassConstraints
        .firstWhere((c) => c.name == superClass)
        .typeArguments
        .first
        .name;
    final protoName = '\$pb.$protoNameSuffix';
    final newClassName = '${className}s';
    return """
class $newClassName extends $superClass<$protoName>
    with ${interfaces.followedBy([className]).join(', ')} {
  $newClassName._(TransactionContext context)
      : super(context, () => $protoName());
  static $className make(TransactionContext context) =>
      $newClassName._(context);
}
""";
  }
}

Builder tasteRequestBuilder(BuilderOptions options) =>
    SharedPartBuilder([TasteRequestGenerator()], 'taste_request');
Builder firestoreProtoBuilder(BuilderOptions options) =>
    SharedPartBuilder([FirestoreProtoGenerator()], 'firestore_proto');
