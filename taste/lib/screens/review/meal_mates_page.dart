import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/theme/style.dart';

class MealMatesPage extends StatelessWidget {
  const MealMatesPage({Key key, this.review}) : super(key: key);
  final Post review;
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Meal Mates", style: kAppBarTitleStyle),
        centerTitle: true,
      ),
      body: ListView(
          children: ListTile.divideTiles(
                  context: context,
                  tiles: review.mealMates
                      .asMap()
                      .entries
                      .map((e) => FutureBuilder<TasteUser>(
                          future: e.value.fetch(),
                          builder: (context, snapshot) => ListTile(
                              key: Key(e.key.toString()),
                              title: Text(snapshot.data?.name ?? ''),
                              leading: Hero(
                                  tag: MealMateHeroTag(
                                      user: e.value, review: review.reference),
                                  child: ProfilePhoto(
                                    radius: 25,
                                    user: snapshot.data?.reference,
                                  )),
                              onTap: () => (snapshot.data == null)
                                  ? null
                                  : snapshot.data.goToProfile())))
                      .toList())
              .toList()));
}

class MealMateHeroTag with EquatableMixin {
  MealMateHeroTag({@required this.user, @required this.review});
  final DocumentReference user;
  final DocumentReference review;

  @override
  List<Object> get props => [user, review];
}
