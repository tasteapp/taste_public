import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/components/taste_progress_indicator.dart';
import 'package:taste/providers/firebase_user_provider.dart';
import 'package:taste/screens/connect_users/recommendations.dart';
import 'package:taste/screens/log_in/log_in_screen.dart';
import 'package:taste/screens/logged_in/logged_in.dart';
import 'package:taste/taste_backend_client/favorites_manager.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';

import 'never_logged_in_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<TasteFirebaseUser>(
      stream: tasteFirebaseUser,
      builder: (context, snapshot) => snapshot.data.when(
          user: (_) => MultiProvider(
                providers: [
                  favoritesProvider,
                  recommendationsProvider,
                ],
                child: const LoggedInView(),
              ),
          neverLoggedIn: () => NeverLoggedInPage(),
          loggedOut: () => const LogInScreen(),
          initial: () =>
              const Center(child: TasteLargeCircularProgressIndicator())));
}
