import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/taste_backend_client/favorites_manager.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/loading.dart';

class _AddFavoriteWidget extends StatelessWidget {
  const _AddFavoriteWidget(
      {@required this.restaurantReference, @required this.builder})
      : super();
  final DocumentReference restaurantReference;
  final Widget Function(
      BuildContext context, Future Function() onTap, bool isFavorited) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: isFavoritedStream(restaurantReference),
        builder: (context, snapshot) {
          final isFavorited = snapshot.data ?? false;
          return builder(context, () async {
            final Restaurant restaurant =
                await spinner(restaurantReference.fetch);
            if (isFavorited) {
              await restaurant.favorite(enable: false);
              snackBarString('Removed', seconds: 2);
              return;
            }
            final doAdd = await showDialog<bool>(
                context: context,
                builder: (context) => TasteDialog(
                      title: 'Add ${restaurant.name} as a favorite?',
                      buttons: [
                        TasteDialogButton(
                            text: 'Cancel',
                            onPressed: () => Navigator.pop(context, false)),
                        TasteDialogButton(
                            text: 'Yes',
                            onPressed: () => Navigator.pop(context, true)),
                      ],
                    ));
            if (!(doAdd ?? false)) {
              return;
            }
            final status = await addFavorite(context, restaurant);
            if (status.isError) {
              if (status == FavoriteStatus.limit) {
                return showOpenFavoritesEditorDialog(context);
              }
              return status.maybeSnackbar();
            }
            snackBarString('Success!');
          }, isFavorited);
        });
  }

  Future showOpenFavoritesEditorDialog(BuildContext context,
      {String message}) async {
    tasteSnackBar(const SnackBar(
        content:
            Text('Favorites limit reached. You can edit your favorites on your'
                ' profile page!')));
    // TODO(team): navigate to profile page favorites tab in "EditFavorites"
    // mode.
  }
}

class AddFavoriteTile extends StatelessWidget {
  const AddFavoriteTile({@required this.restaurant}) : super();
  final DocumentReference restaurant;

  @override
  Widget build(BuildContext context) => _AddFavoriteWidget(
      restaurantReference: restaurant,
      builder: (context, onTap, isFavorited) => ListTile(
          leading: _FavoriteIcon(isFavorited: isFavorited),
          title: Text(isFavorited ? "Remove Favorite" : "Add Favorite"),
          onTap: () async {
            await onTap();
            Navigator.pop(context);
          }));
}

class AddFavoriteButton extends StatelessWidget {
  const AddFavoriteButton({@required this.restaurant}) : super();
  final DocumentReference restaurant;

  @override
  Widget build(BuildContext context) => _AddFavoriteWidget(
      restaurantReference: restaurant,
      builder: (context, onTap, isFavorited) => IconButton(
          icon: _FavoriteIcon(isFavorited: isFavorited), onPressed: onTap));
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({Key key, this.isFavorited}) : super(key: key);
  final bool isFavorited;
  @override
  Widget build(BuildContext context) => Icon(TrophyOutlineIcons.trophy,
      color: isFavorited ?? false ? Colors.blue : Colors.grey);
}
