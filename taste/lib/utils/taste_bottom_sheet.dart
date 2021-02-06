import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';

/// Adds a transparent widget above the bottomSheet that essentially allows the
/// user to intuitively tap/exit out of the modal. Default behavior is for
/// modal to show even when user is interacting with stuff above the bottom
/// sheet. Lame.
PersistentBottomSheetController<T> showTasteBottomSheet<T>(
    BuildContext context, WidgetBuilder builder) {
  return showBottomSheet<T>(
    context: context,
    builder: (context) => Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
        ),
        Container(
          color: kPrimaryBackgroundColor,
          child: Builder(builder: builder),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
  );
}

class TasteBottomSheetItem {
  const TasteBottomSheetItem({this.title, this.callback});

  final String title;
  final VoidCallback callback;
}

PersistentBottomSheetController<T> showTasteBottomSheetWithItems<T>(
    BuildContext context, List<TasteBottomSheetItem> items) {
  return showTasteBottomSheet(
      context,
      (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: ListTile.divideTiles(
              context: context,
              tiles: items
                  .map((option) => ListTile(
                      title: Text(
                        option.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        option.callback();
                      }))
                  .toList(),
            ).toList(),
          ));
}
