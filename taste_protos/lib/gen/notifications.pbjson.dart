///
//  Generated code. Do not modify.
//  source: notifications.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const ClickAction$json = const {
  '1': 'ClickAction',
  '2': const [
    const {'1': 'FLUTTER_NOTIFICATION_CLICK', '2': 0},
  ],
};

const FcmExtras$json = const {
  '1': 'FcmExtras',
  '2': const [
    const {'1': 'notification_type', '3': 1, '4': 1, '5': 14, '6': '.firestore.NotificationType', '10': 'notificationType'},
    const {'1': 'notification_path', '3': 2, '4': 1, '5': 9, '10': 'notificationPath'},
    const {'1': 'document_link', '3': 3, '4': 1, '5': 9, '10': 'documentLink'},
    const {'1': 'user', '3': 4, '4': 1, '5': 9, '10': 'user'},
  ],
};

const FcmMessage$json = const {
  '1': 'FcmMessage',
  '2': const [
    const {'1': 'notification', '3': 1, '4': 1, '5': 11, '6': '.notifications.FcmMessage.Notification', '10': 'notification'},
    const {'1': 'data', '3': 2, '4': 1, '5': 11, '6': '.notifications.FcmMessage.Data', '10': 'data'},
  ],
  '3': const [FcmMessage_Notification$json, FcmMessage_Data$json],
};

const FcmMessage_Notification$json = const {
  '1': 'Notification',
  '2': const [
    const {'1': 'body', '3': 1, '4': 1, '5': 9, '10': 'body'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
  ],
};

const FcmMessage_Data$json = const {
  '1': 'Data',
  '2': const [
    const {'1': 'extras', '3': 1, '4': 1, '5': 9, '10': 'extras'},
    const {'1': 'click_action', '3': 2, '4': 1, '5': 14, '6': '.notifications.ClickAction', '10': 'clickAction'},
  ],
};

