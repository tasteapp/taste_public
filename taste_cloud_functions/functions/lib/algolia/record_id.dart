import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

class AlgoliaRecordID with EquatableMixin {
  final DocumentReference reference;
  final $pb.AlgoliaRecordType recordType;
  String get objectID => [enumToString(recordType), reference.path].join(' ');
  AlgoliaRecordTypeData get recordTypeData => recordTypes[recordType];
  AlgoliaRecordID(this.reference, this.recordType);
  @override
  List<Object> get props => [reference, recordType];

  @override
  String toString() {
    return props.toString();
  }
}
