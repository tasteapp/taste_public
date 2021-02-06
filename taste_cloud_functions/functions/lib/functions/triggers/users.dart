import 'package:taste_cloud_functions/taste_functions.dart';

export 'package:firebase_functions_interop/firebase_functions_interop.dart'
    show UserRecord;

const _kGooglePhotoLoResSuffix = '=s96-c';

/// Converts default profile photo URL to 400x400 size URL, which is much better
/// than the default 50x50.
String _getHigherResPhotoUrl(String photoUrl) {
  if (photoUrl == null) {
    return null;
  }
  // FB profile photos.
  if (photoUrl.contains('graph.facebook.com') &&
      photoUrl.endsWith('/picture')) {
    return '$photoUrl?height=400&width=400';
  }
  // Google profile photos.
  if (photoUrl.endsWith(_kGooglePhotoLoResSuffix)) {
    return photoUrl.replaceAll(_kGooglePhotoLoResSuffix, '');
  }
  return photoUrl;
}

const _randomNameAdjectives = [
  'Curious',
  'Fuzzy',
  'Swanky',
  'Lit',
  'Enthusiastic',
  'Skillful',
  'Cheerful',
  'Lucky',
  'Righteous',
  'Animated',
  'Gifted',
  'Acoustic',
  'Magical',
  'Fluffy',
  'Super',
  'Quirky',
  'Mindful',
  'Misty',
  'Fragrant',
  'Indelible',
  'Sneaky',
  'Quaint',
  'Majestic',
  'Witty',
  'Reflective',
  'Cheeky',
  'Mighty',
  'Lively',
  'Serendipitous',
];

const _randomNameNouns = [
  'Cheese',
  'Broccoli',
  'Pizza',
  'Doughnut',
  'Muffin',
  'Bagel',
  'Tomato',
  'Potato',
  'Apple',
  'Truffle',
  'Cabbage',
  'Bacon',
  'Biscuit',
  'Brisket',
  'Cashew',
  'Cherry',
  'Cookie',
  'Dragonfruit',
  'Fennel',
  'Guacamole',
  'Sushi',
  'Kiwi',
  'Okra',
  'Mochi',
  'Oyster',
  'Toast',
];

const _randomNameSuffixMaxRange = 100;

Future<String> generateRandomUsername() async {
  final name = getRandomName();
  if ((await TasteUsers.collection
          .where('vanity.username', isEqualTo: name)
          .limit(1)
          .get())
      .documents
      .isNotEmpty) {
    return generateRandomUsername();
  }
  return name;
}

String getRandomName() {
  final random = Random();
  final adj =
      _randomNameAdjectives[random.nextInt(_randomNameAdjectives.length)];
  final noun = _randomNameNouns[random.nextInt(_randomNameNouns.length)];
  final suffix = random.nextInt(_randomNameSuffixMaxRange);
  return '$adj$noun$suffix';
}

@visibleForTesting
Future<TasteUser> createUserRecord(
    UserRecord user, BatchedTransaction transaction) async {
  final isGuestMode = user.email == null &&
      user.providerData.isEmpty &&
      user.tokensValidAfterTime == null;
  final randomName = await generateRandomUsername();
  final tasteUser = (await TasteUsers.createNew(transaction,
      data: {
        'display_name': isGuestMode ? randomName : user.displayName,
        'photo_url': _getHigherResPhotoUrl(user.photoURL),
        'vanity': {
          'has_set_up_account': false,
          'display_name': isGuestMode ? randomName : user.displayName,
          'username': randomName,
        },
        'email': user.email,
        'guest_mode': isGuestMode,
        'uid': user.uid,
      }.ensureAs(TasteUsers.emptyInstance).documentData.withExtras,
      documentId: user.uid));
  await tasteUser.updatePrivate(
      {'email': user.email, 'email_verified': user.emailVerified});
  if (buildType == BuildType.prod) {
    await sendSlack(
        isGuestMode
            ? 'New user as guest: $randomName'
            : 'New user: ${user.displayName}, ${user.email}',
        hook: SlackChannelHooks.newUser);
  }
  return tasteUser;
}

final addUserRecordOnAuthSignup = functions.auth.user().onCreate(
    (user, context) =>
        autoBatch((transaction) => createUserRecord(user, transaction)));

final deleteUserRecordOnAuthDelete = functions.auth
    .user()
    .onDelete((user, _) async => (await user.reference)?.delete());

void register() {
  registerFunction('addUserRecordOnAuthSignup', addUserRecordOnAuthSignup,
      addUserRecordOnAuthSignup);
  registerFunction('deleteUserRecordOnAuthDelete', deleteUserRecordOnAuthDelete,
      deleteUserRecordOnAuthDelete);
}
