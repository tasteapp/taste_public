import 'package:taste_cloud_functions/taste_functions.dart';

class CallRequest<T extends GeneratedMessage> with TransactionHolder, Memoizer {
  final TransactionContext context;
  final T Function() protoCreator;
  T get prototype => protoCreator();
  @protected
  T get request => memoize(() => data.asProto(prototype), 'request');
  CallRequest(this.context, this.protoCreator);
  @protected
  Map<String, dynamic> get data => context.data;
  @override
  @protected
  BatchedTransaction get transaction => context.transaction;
  @override
  String get eventId => context.context.eventId;
  Future<TasteUser> get requestUser =>
      memoize(() => context.tasteUser, 'requestUser');
}
