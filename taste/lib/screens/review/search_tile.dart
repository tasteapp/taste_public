import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    @required Key key,
    @required this.type,
    @required this.id,
    @required this.text,
    this.subtitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);
  final CollectionType type;
  final String id;
  final String text;
  final String subtitle;
  final Function() onTap;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final icon = type == CollectionType.users
        ? ProfilePhoto(
            user: id.ref,
            radius: 20,
          )
        : this.icon;
    final Decoration decoration = BoxDecoration(
      border: Border(
        bottom: Divider.createBorderSide(context, color: Colors.grey),
      ),
    );
    final tile = ListTile(
      title: Text(text ?? ''),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: icon,
      dense: true,
      onTap: onTap,
      trailing: Container(height: 60, width: 60, child: trailing),
    );
    return Container(decoration: decoration, child: tile);
  }

  Icon get icon => Icon({
        CollectionType.users: Icons.person,
        CollectionType.restaurants: Icons.restaurant,
        CollectionType.reviews: Icons.rate_review,
        CollectionType.home_meals: Icons.rate_review,
        CollectionType.cities: FontAwesome.map_marker,
      }[type] ??
      Icons.list);
}
