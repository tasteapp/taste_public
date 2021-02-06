import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/extensions.dart';
import 'ask_phone_number.dart';

final _perms = PermissionHandler();

const _key = 'ask-phone-number-find-contacts';
final _storage = LocalStorage(_key);
Future<bool> _askedToday() => _storage.ready
    .then((_) => (_storage.getItem(_key) as int ?? 0) == DateTime.now().day);
Future _ask() => _storage.setItem(_key, DateTime.now().day);

Future<bool> _requestPermissions(BuildContext context) async {
  final permissions =
      await _perms.checkPermissionStatus(PermissionGroup.contacts);
  if (permissions == PermissionStatus.granted) {
    return true;
  }
  if (Platform.isAndroid ||
      (Platform.isIOS && permissions == PermissionStatus.unknown)) {
    await _perms.requestPermissions([PermissionGroup.contacts]);
  } else if (Platform.isIOS && permissions == PermissionStatus.denied) {
    if (await showDialog(
            context: context,
            builder: (context) {
              return TasteDialog(
                title:
                    "Taste currently doesn't have permission to view your contacts.",
                content: const Text(
                    "Would you like to go to settings and allow access to contacts?"),
                buttons: [
                  TasteDialogButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.of(context).pop(false)),
                  TasteDialogButton(
                      text: 'Settings',
                      onPressed: () => Navigator.of(context).pop(true)),
                ],
              );
            }) ??
        false) {
      await _perms.openAppSettings();
    }
  }
  return (await _perms.checkPermissionStatus(PermissionGroup.contacts)) ==
      PermissionStatus.granted;
}

class FindContacts extends StatefulWidget {
  const FindContacts();

  @override
  _FindContactsState createState() => _FindContactsState();
}

class _ContactsAndMatchingUsers {
  _ContactsAndMatchingUsers(
      this.hasContactsPermissions, this.users, this.contacts);
  final bool hasContactsPermissions;
  final List<TasteUser> users;
  final List<Contact> contacts;
  int get length => users.length + contacts.length;
  Widget widget(int i) => i < users.length
      ? UserListEntry(users[i])
      : UserContactEntry(contacts[i - users.length]);
}

class _FindContactsState extends State<FindContacts> {
  Stream<_ContactsAndMatchingUsers> contactsAndMatchingUsers;
  final textController = TextEditingController();
  final textStream = StreamController<String>();
  // A cached stream of all contacts.
  // Since contacts are streamed in one at a time, this value is very dynamic
  // at first, but becomes static when the contacts are done loading.
  static final _allContactsStream = Contacts.streamContacts(
          bufferSize: 100, withHiResPhoto: false, withThumbnails: false)
      .collect
      .sampleTime(const Duration(seconds: 5))
      .shareValueSeeded([])
        ..listen((_) {});

  @override
  void initState() {
    super.initState();
    // Grab all users to match contacts against.
    final users = CollectionType.users.coll.fetch<TasteUser>();
    // Create a stream of updates from the text controller
    textController
        .addListener(() => textStream.add(textController.text.toLowerCase()));
    textStream.add(textController.text);
    // First, we need permissions.
    contactsAndMatchingUsers = Future
        .microtask(() =>
            _requestPermissions(context)).asStream().switchMap((has) => !has
        // If we don't have it, we can't create a stream, so exit early.
        ? Stream.value(_ContactsAndMatchingUsers(false, null, null))
        // Now that we have permissions, read from the search text-field.
        : textStream.stream.switchMap((term) => (term.isEmpty
                    // If no search term, show all contacts from the cached non-search
                    // stream
                    ? _allContactsStream
                    // Otherwise, grab a new stream for this search term
                    : Contacts.streamContacts(
                            query: term,
                            bufferSize: 100,
                            withHiResPhoto: false,
                            withThumbnails: false)
                        .collect
                        .sampleTime(const Duration(milliseconds: 300)))
                .switchMap((contacts) {
              /// For each new [contacts], pair it with the latest value from
              /// the [users] stream to see which contacts match which users.
              // Create all search tokens that TasteUser's can match against.
              final tokens = contacts.expand((c) => c.tokens).toSet();
              return users.asStream().map((users) => _ContactsAndMatchingUsers(
                  true,
                  users

                      /// Compute a "match" score for each [user].
                      /// The match score has two components:
                      /// 1. How well it matches the search term
                      /// 2. How well it matches the contacts.
                      .zipWith((user) => [
                            // score 1)
                            user.tokens
                                .where((token) =>
                                    term.isNotEmpty && token.contains(term))
                                .map((token) => token.length)
                                .sum,
                            // score 2)
                            user.tokens
                                .intersection(tokens)
                                .where((token) => token.isNotEmpty)
                                .length
                          ])
                      // Require a contacts token match.
                      .where((e) => e.b[1] > 1)
                      // Prioritize higher match scores.
                      .sorted((a) => -a.b.sum)
                      .a
                      .toList(),
                  contacts));
            })));
    // Show a phone-number request if the user doesn't have a phone number
    // uploaded and hasn't been asked yet today.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => cachedLoggedInUser.then((user) async {
              if (user.hasPhoneNumber) {
                return;
              }
              if (await _askedToday()) {
                return;
              }
              await _ask();
              await quickPush(TAPage.ask_phone_number,
                  (context) => const AskPhoneNumberWidget());
            }));
  }

  @override
  Widget build(BuildContext context) => Unfocusable(
      child: StreamBuilder<_ContactsAndMatchingUsers>(
          stream: contactsAndMatchingUsers,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const Center(child: CircularProgressIndicator())
                : !(snapshot.data.hasContactsPermissions ?? false)
                    ? const Center(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                "Grant Taste permission to access your contacts in order to find and invite friends",
                                style: TextStyle(fontSize: 16))))
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              textCapitalization: TextCapitalization.words,
                              controller: textController,
                              decoration: const InputDecoration(
                                  hintText: "Search Contacts"),
                              autofocus: false,
                              autocorrect: false,
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                                cacheExtent:
                                    MediaQuery.of(context).size.height * 2,
                                itemCount: snapshot.data.length,
                                itemBuilder: (c, i) => snapshot.data.widget(i),
                                separatorBuilder: (c, i) => const Divider()),
                          ),
                        ],
                      );
          }));
}

class UserContactEntry extends StatelessWidget {
  const UserContactEntry(this.contact);
  final Contact contact;
  String get displayName => contact.displayName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: Key(displayName),
        title: Text(displayName ?? "Unknown"),
        leading: CircleAvatar(
            radius: 20,
            backgroundImage: contact.avatar?.isEmpty ?? true
                ? null
                : MemoryImage(contact.avatar),
            child: Text(displayName == null ? "?" : displayName[0])),
        trailing: OutlineButton(
            disabledTextColor: Colors.grey,
            onPressed: () async {
              if (displayName == null) {
                return;
              }
              TAEvent.clicked_invite_friend();
              final message = 'Follow me on Taste!\n'
                  'Username: ${(await cachedLoggedInUser)?.username ?? ''}\n'
                  'https://trytaste.app';
              await launch(
                  'sms:${contact.phones.first.value.sms}${Platform.isIOS ? "&" : "?"}body=${Uri.encodeFull(message)}');
            },
            child: const Text(
              "Invite",
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            )));
  }
}

extension on String {
  String get sms => '+${contains('+') ? '' : 1}$phoneToken';
  String get phoneToken => replaceAll(RegExp(r'[^\d]'), '');
}

extension on Contact {
  Set<String> get tokens => {displayName}
      .followedBy(phones.map((p) => p.value))
      .expand((e) => e == null ? <String>[] : e.toLowerCase().split(' '))
      .toSet()
        ..remove(' ');
}

extension on TasteUser {
  Set<String> get tokens => {name, phoneNumber, email}
      .expand((e) => e.toLowerCase().split(' '))
      .toSet()
        ..remove(' ');
}
