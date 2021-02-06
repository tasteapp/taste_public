import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/create_review/take_photo.dart';
import 'package:taste/screens/discover/components/top_widget.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/third_party/image_crop/image_crop.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/utils.dart';

import 'post_photo_manager.dart';

class CreateReviewEditPhotosPage extends StatefulWidget {
  const CreateReviewEditPhotosPage(this.bloc);
  final PostPhotoManager bloc;

  @override
  _CreateReviewEditPhotosPageState createState() =>
      _CreateReviewEditPhotosPageState();
}

@immutable
class _State {
  const _State(
      this.files, this.activeIndex, this.activeFile, this.notifier, this.bloc);
  final List<File> files;
  final int activeIndex;
  final File activeFile;
  final ValueNotifier<File> notifier;
  final PostPhotoManager bloc;
}

class _CreateReviewEditPhotosPageState
    extends State<CreateReviewEditPhotosPage> {
  ValueNotifier<File> notifier;

  @override
  void initState() {
    super.initState();
    notifier = ValueNotifier(null);
  }

  PostPhotoManager get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<File>(
      valueListenable: notifier,
      builder: (context, activeFile, _) =>
          BlocBuilder<PostPhotoManager, PostPhotoState>(
              bloc: bloc,
              builder: (context, state) {
                final activeIndex = max(0, state.files.indexOf(activeFile));
                activeFile = state.files[activeIndex];
                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                          onPressed: state.files.length >= maxPhotosPerPost
                              ? null
                              : () async => bloc.add(PostPhotoEvent.add(
                                  (await pickAssetFiles(context,
                                          numExisting: state.files.length))
                                      .listMap((t) => t.file))),
                          icon: const Icon(Icons.add_a_photo)),
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.check),
                      )
                    ],
                    centerTitle: true,
                    title: Text(
                      "Edit Photo${state.files.length > 1 ? 's' : ''}",
                      style: kAppBarTitleStyle,
                    ),
                  ),
                  body: DataHolder(
                    data: _State(
                        state.files, activeIndex, activeFile, notifier, bloc),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(child: BigImagePanel()),
                        ImageListPanel(),
                      ],
                    ),
                  ),
                );
              }));
}

abstract class _ChildWidget extends DataRequester<_State> {
  const _ChildWidget({Key key}) : super(key: key);
}

class ImageListPanel extends _ChildWidget {
  const ImageListPanel();

  @override
  Widget dataBuild(BuildContext context, _State data) => AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height:
          data.files.length < 2 ? 0 : (MediaQuery.of(context).size.height / 4),
      padding: const EdgeInsets.all(12.0),
      child: ReorderableListView(
          onReorder: (a, b) => data.bloc.add(PostPhotoEvent.reordered(a, b)),
          scrollDirection: Axis.horizontal,
          children: data.files.enumerate
              .entryMap((i, file) =>
                  ListImageCard(key: ValueKey(file), index: i, file: file))
              .toList()));
}

class ListImageCard extends _ChildWidget {
  const ListImageCard(
      {@required Key key, @required this.index, @required this.file})
      : super(key: key);
  final int index;
  final File file;

  @override
  Widget dataBuild(BuildContext context, _State data) => Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: data.activeFile == file
              ? const BorderSide(color: kChipActiveColor, width: 2)
              : BorderSide.none),
      key: ValueKey(file),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: InkWell(
          onTap: () => data.notifier.value = file,
          child: Stack(children: <Widget>[
            Container(
                color: Colors.black,
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 5,
                    maxWidth: MediaQuery.of(context).size.width / 4),
                child: Builder(
                  builder: (context) => Image.file(file,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fitHeight),
                )),
            Positioned(
                top: 4,
                right: 4,
                child: Visibility(
                    visible: index == 0,
                    child: Card(
                        elevation: 3,
                        color: Colors.white,
                        child: InkWell(
                            onTap: () => snackBarString(
                                'This photo will show up first on posts'),
                            child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: AutoSizeText("Primary",
                                    maxLines: 1,
                                    minFontSize: 8,
                                    maxFontSize: 13,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kTasteBrandColorLeft)))))))
          ])));
}

class BigImagePanel extends _ChildWidget {
  const BigImagePanel();

  @override
  Widget dataBuild(BuildContext context, _State data) => Container(
      color: Colors.black,
      child: Stack(children: const [
        Align(alignment: Alignment.center, child: BigImageView()),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ActionButtonRow(),
            ))
      ]));
}

class BigImageView extends _ChildWidget {
  const BigImageView();
  @override
  Widget dataBuild(BuildContext context, _State data) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: PhotoView.customChild(
        minScale: 1.0,
        maxScale: 1.0,
        child: Image.file(data.activeFile, fit: BoxFit.contain),
      ));
}

class ActionButtonRow extends _ChildWidget {
  const ActionButtonRow();
  @override
  Widget dataBuild(BuildContext context, _State data) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [DeleteButton(), CropButton()]);
}

class DeleteButton extends _ChildWidget {
  const DeleteButton();
  @override
  Widget dataBuild(BuildContext context, _State data) => Visibility(
      visible: data.files.length > 1,
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.white,
        mini: true,
        onPressed: () => data.bloc.add(
          PostPhotoEvent.deleted(data.activeIndex),
        ),
        child: const Icon(Icons.delete, color: Colors.black),
      ));
}

class CropButton extends _ChildWidget {
  const CropButton();
  @override
  Widget dataBuild(BuildContext context, _State data) => FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.white,
        mini: true,
        onPressed: () async {
          if (!await ImageCrop.requestPermissions()) {
            snackBarString('Permissions required to crop');
            return;
          }
          final newFile = Platform.isIOS
              ? await ImageCropper.cropImage(sourcePath: data.activeFile.path)
              : await quickPush<File>(
                  TAPage.crop_image_page,
                  (_) =>
                      DataHolder<_State>(data: data, child: const CropPage()));
          if (newFile == null) {
            return;
          }
          data.bloc.add(PostPhotoEvent.edited(data.activeIndex, newFile));
        },
        child: const Icon(Icons.crop, color: Colors.black),
      );
}

class CropPage extends _ChildWidget {
  const CropPage();
  static final cropKey = GlobalKey<CropState>();
  @override
  Widget dataBuild(BuildContext context, _State data) => Scaffold(
      appBar: AppBar(
          title: const Text("Resize Photo", style: kAppBarTitleStyle),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async => Navigator.pop(
                  context,
                  await spinner(() => ImageCrop.cropImage(
                        file: data.activeFile,
                        area: cropKey.currentState.area,
                      ))),
              icon: const Icon(Icons.check),
            )
          ]),
      body: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(20.0),
          child: Crop.file(
            data.activeFile,
            key: cropKey,
            minAspect: 2 / 3,
            maxAspect: 1,
          )));
}
