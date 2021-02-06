import 'package:auto_size_text/auto_size_text.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/badge.dart';

class SlowRoute extends MaterialPageRoute {
  SlowRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);
  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);
}

class BadgeTile extends StatelessWidget {
  const BadgeTile({Key key, this.badge, this.size = 50, @required this.user})
      : super(key: key);

  final Badge badge;
  final double size;
  final TasteUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.only(top: 4),
      child: Opacity(
        opacity: badge.isInactive ? 0.35 : 1,
        child: Card(
          elevation: 5,
          color: badge.isInactive ? Colors.grey[400] : null,
          child: Center(
            child: InkWell(
                onTap: badge.goTo,
                child: Stack(alignment: Alignment.topRight, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Center(
                                  child: Hero(tag: badge, child: badge.icon))),
                          Expanded(
                            child: AutoSizeText(
                              badge.details.description,
                              maxLines: 1,
                              maxFontSize: 14,
                              minFontSize: 6,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Hero(
                        tag: HeroBadgeLevelTag(badge),
                        child: badge.level?.icon ??
                            const Icon(Icons.lock, color: Colors.grey)),
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}

class HeroBadgeLevelTag with EquatableMixin {
  HeroBadgeLevelTag(this.badge);
  final Badge badge;

  @override
  List<Object> get props => [badge];
}
