import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/create_review/review/create_review.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart'
    show BugReport, BugReportType, FirePhoto;

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({Key key, @required this.type}) : super(key: key);
  final BugReportType type;
  @override
  _UserReportScreenState createState() => _UserReportScreenState();
}

final _formKey = GlobalKey<FormState>();

class _UserReportScreenState extends State<UserReportScreen> {
  final TextEditingController reportTextController = TextEditingController();
  final _imageController = StreamController<File>();

  /// The photos which are currently being processed.
  ///
  /// We want futures and not resolved futures for this stream so that the UI
  /// can show how many photos are currently processing, not the count of photos
  /// that have already processed.
  Stream<List<Future<FirePhoto>>> photos;

  @override
  void initState() {
    super.initState();
    photos = _imageController.stream
        .where((x) => x != null)
        .map(uploadPhoto)
        .collect
        .shareValueSeeded([]);
  }

  @override
  void dispose() {
    _imageController.close();
    super.dispose();
  }

  bool get isBug => widget.type == BugReportType.bug_report;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Future<FirePhoto>>>(
        stream: photos,
        initialData: const [],
        builder: (context, snapshot) {
          final photos = snapshot.data;
          final submit = () async {
            if (!_formKey.currentState.validate()) {
              return;
            }
            await spinner(() async {
              // Create the document without photos immediately, in case the user
              // hits bad network, we at least get the text report.
              final reference = await CollectionType.bug_reports.coll.add({
                'user': currentUserReference,
                'metadata': await metadata,
                'text': reportTextController.text,
                'report_type': widget.type,
              }.ensureAs(BugReport()).withExtras);
              // Then attach the photos to the new document once they're done.
              // Don't wait on this to make the UI snappy.
              unawaited(photos.wait.then((photos) => reference.updateData({
                    'bug_photos':
                        photos.map((p) => p.photoReference.ref).toList()
                  }.ensureAs(BugReport()))));
            });
            Navigator.pop(context);
            snackBarString('Thank you! 🙏');
          };
          return Theme(
            data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey))),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  isBug ? 'Report a Bug' : 'Provide Feedback',
                  style: kAppBarTitleStyle,
                ),
                actions: [
                  FlatButton(
                    onPressed: submit,
                    child: AutoSizeText(
                      'Submit',
                      style: reviewTextStyle(color: kPrimaryButtonColor),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              body: Unfocusable(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: TasteButton(
                          options: const TasteButtonOptions(
                            color: kPrimaryButtonColor,
                            textColor: Colors.white,
                          ),
                          iconData: Icons.add_a_photo,
                          text: '${photos.length} screenshots added',
                          onPressed: () async => _imageController.add(
                            File((await ImagePicker().getImage(
                              source: ImageSource.gallery,
                              maxWidth: 1000,
                              maxHeight: 1000,
                              imageQuality: 50,
                            ))
                                ?.path),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: isBug
                                  ? "What went wrong?"
                                  : "Suggestions, Feedback, Feature Requests",
                              hintText: "The more detail the better"),
                          controller: reportTextController,
                          validator: (text) => text.length < 5
                              ? 'Please write a little more detail.'
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
