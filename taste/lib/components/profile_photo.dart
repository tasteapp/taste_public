import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';

import 'taste_cache.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto(
      {Key key,
      @required this.user,
      this.radius = 40,
      this.padding,
      this.tapToProfileHero = false,
      this.path,
      Object hero})
      : hero = hero ?? Object(),
        super(key: key);
  final double radius;
  final bool tapToProfileHero;
  final EdgeInsets padding;
  final DocumentReference user;
  final String path;
  final Object hero;

  static final _cache = tasteFutureCache<DocumentReference, String>(
      (user) async => (await user.fetch<TasteUser>()).profileImage());

  Widget builder(BuildContext context, String url) {
    // Robust
    final isEmpty = url?.isEmpty ?? true;
    final photo = CircleAvatar(
      radius: radius,
      backgroundImage: isEmpty ? null : CachedNetworkImageProvider(url),
      backgroundColor: Color.alphaBlend(
        kPrimaryButtonColor.withOpacity(0.1),
        Colors.white,
      ),
      child: isEmpty ? _EmptyProfile(radius: radius * 1.33) : null,
    );
    return tapToProfileHero
        ? InkWell(
            onTap: () => goToUserProfile(user, hero: hero),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(6),
              child: Hero(tag: hero, child: photo),
            ))
        : photo;
  }

  // Goals:
  // 1. Save network calls:
  //   a. If [path] is available, just use that, so we don't call firestore.
  //   b. Cache the same profile picture for a user for a day.
  // 2. Snappiness
  //   a. Store cache values as ValueListenable, which accomplishes:
  //     i. If not fetched yet, returns a null-valued listenable, which upgrades to completed when available.
  //     ii. Otherwise, the listenable is already complete and will show the photo on  first widget build.
  //       I: Note: Using FutureBuilder would cause a flicker because first widget build is null.
  // 3. Freshness
  //   a. If the logged-in user updates their picture, it will live update everywhere ProfilePhoto is used for that user.
  //     i. This is an optimization for the logged-in user.
  // 4. Robustness
  //   a. If input is malformed, always show the profile-icon instead of failure or blank white.
  @override
  Widget build(BuildContext context) => user == null && path == null
      // Robust
      ? builder(context, null)
      // Fresh
      : currentUserReference == user
          ? ValueStreamBuilder<String>(
              stream: tasteUserStream.valueMap((t) => t.profileImage()),
              builder: (context, snapshot) => builder(context, snapshot.data))
          // Save network and Snappy
          : path != null
              ? builder(context, path)
              // Snappy
              : ValueListenableBuilder<String>(
                  valueListenable: _cache.find(user),
                  builder: (context, url, _) => builder(context, url));
}

class _EmptyProfile extends StatelessWidget {
  const _EmptyProfile({Key key, this.radius}) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) => Icon(
        Icons.person_outline,
        size: radius,
        color: Color.alphaBlend(
          kPrimaryButtonColor.withOpacity(0.66),
          Colors.white,
        ),
      );
}
