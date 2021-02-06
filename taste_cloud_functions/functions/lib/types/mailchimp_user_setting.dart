import 'package:mailchimp/mailchimp.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'mailchimp_user_setting.g.dart';

@RegisterType()
mixin MailchimpUserSetting
    on FirestoreProto<$pb.MailchimpUserSetting>, UserOwned {
  static final triggers = trigger<MailchimpUserSetting>(
      create: (r) => r._sync(), update: (r, c) => r._sync(c));
  Future _sync([Change<MailchimpUserSetting> change]) async {
    final previousTags = change?.before?.tags ?? {};
    final tags = this.tags;
    final add = tags.difference(previousTags);
    final remove = previousTags.difference(tags);
    if ({...add, ...remove}.isEmpty) {
      return;
    }
    final email = (await user).proto.email;
    if (email.isEmpty) {
      return;
    }
    await mailchimp(
        updateTags(mailchimpAudience, email, add: add, remove: remove));
  }

  Set<String> get tags => proto.tags.toSet();

  static void registerInternal() {
    final fn = tasteFunctions.pubsub
        .topic('mailchimp-tags')
        .onPublish((message, context) => noLogInUids());
    registerFunction('mailchimp_tags', fn, fn);
  }
}

Future noLogInUids() => autoBatch((t) async {
      final uids = (await tasteBQ(
              '''SELECT uid FROM `$projectId.scheduled.no_log_in_week`''',
              (x) => x.first))
          .toSet();
      final tags = {'one_week_inactive'};
      const empty = <String>{};
      await (await TasteUsers.get(trans: t)).futureMap((t) {
        final contains = uids.contains(t.uid);
        // Disable mailchimp one-week-inactive emails.
        final add = empty; // contains ? tags : empty;
        final remove = tags; // contains ? empty : tags;
        return t.updateMailchimpTags(add: add, remove: remove);
      });
    });
