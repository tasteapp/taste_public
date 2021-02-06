import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:taste/screens/profile/notifications/notification_tile.dart';
import 'package:taste/screens/profile/notifications/taste_notification.dart';
import 'package:taste/screens/review/review.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/appsflyer.dart';
import 'package:taste/utils/scheduled_checks.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import '../utils/collection_type.dart';
import '../utils/extensions.dart';
import 'firebase_user_provider.dart';
import 'taste_snack_bar.dart';

void globalSetup() {
  _onLogin();
  _configureFCM();
  _configureDynamicLinks();
}

void _configureDynamicLinks() {
  Future handle(PendingDynamicLinkData data) async {
    final reference = data?.link?.queryParameters?.getOrNull('id')?.ref;
    if (reference != null) {
      await tasteFirebaseUser.waitForLogin;
      await goToReviewPage(ReviewPageInput.reviewReference(reference));
    }
  }

  FirebaseDynamicLinks.instance.getInitialLink().then(handle);

  FirebaseDynamicLinks.instance.onLink(
      onSuccess: handle,
      onError: (e) => Crashlytics.instance.recordError(e, null));
}

void _configureFCM() {
  _fcm.onTokenRefresh.withoutNulls
      .listen((token) async => (await cachedLoggedInUser)?.updatePrivate({
            'fcm_tokens': FieldValue.arrayUnion([token])
          }));
  //ignore: avoid_types_on_closure_parameters
  final _fcmCallback = (_MessageType messageType) =>
      //ignore: avoid_types_on_closure_parameters
      (Map<String, dynamic> data) async {
        if (messageType == _MessageType.background) {
          return;
        }

        /// Android schema of [data] is:
        /// {
        ///   notification: {body, ...},
        ///   data: {
        ///     extras: {
        ///       document_link:...
        ///     },
        ///     click_action: ...
        ///   },
        /// }
        ///
        /// iOS schema of [data] is:
        /// {
        ///   notification: {body,...},
        ///   extras: {
        ///     document_link:...
        ///   },
        ///   click_action: ...
        /// }
        ///
        /// [$pb.FcmMessage] expects Android schema, so we cast iOS into
        /// Android using magic below.
        data = {
          // Copy root [data]
          ...data,
          // Shove root fields into 'data' sub-field
          'data': {
            // Copy sub-field if it exists
            ...data['data'] ?? {},
            // Copy root fields
            ...data,
          }
        };
        final message = data.asProto($pb.FcmMessage());
        Future add() async {
          TAEvent.routed_notification(
              {'source': messageType.toString().split('.').last});
          await tasteFirebaseUser.waitForLogin;
          notificationHyperlink(TasteNotification(message))();
        }

        if ({_MessageType.resume, _MessageType.launch}.contains(messageType)) {
          return add();
        }
        tasteSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.notification.title.isEmpty
                      ? ""
                      : "${message.notification.title}:",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Text(
                    message.notification.body ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            action: SnackBarAction(label: "See", onPressed: add),
          ),
        );
      };
  _fcm.configure(
    onResume: _fcmCallback(_MessageType.resume),
    onLaunch: _fcmCallback(_MessageType.launch),
    onMessage: _fcmCallback(_MessageType.message),
  );
}

void _onLogin() {
  tasteUserStream.distinct((a, b) => a.uid == b.uid).listen((user) => [
        _privateData,
        _appsflyer,
      ].futureMap((f) => f(user)));
}

final _fcm = FirebaseMessaging();

enum _MessageType {
  launch,
  resume,
  message,
  background,
}

Future _privateData(TasteUser user) async => user.updatePrivate({
      'timezone': await FlutterNativeTimezone.getLocalTimezone(),
      'last_login': DateTime.now(),
    });

Future _appsflyer(TasteUser user) async =>
    AppsflyerManager.instance.registerLogin(user);
