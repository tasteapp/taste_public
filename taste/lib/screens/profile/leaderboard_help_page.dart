import 'package:flutter/material.dart';
import 'package:taste/theme/style.dart';

class LeaderboardHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the Leaderboard", style: kAppBarTitleStyle),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: Text(
          '''
Climb the Taste Leaderboard by participating in the Taste community!

You can increase your score by:

* Most importantly: Making posts!

* Getting your Badge scores up!

* Getting engagement on your posts:
    * Bookmarks
    * Likes
    * Comments
    * Views

* Creating Favorites
* Increasing your follower count

So go out there and Share Your Taste!
    ''',
          style: TextStyle(fontSize: 18),
        )),
      ),
    );
  }
}
