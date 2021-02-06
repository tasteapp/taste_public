import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/screens/log_in/components/log_in.dart';
import 'package:taste/utils/loading.dart';

import 'components/nav/nav.dart';
import 'providers/remote_config.dart';
import 'theme/style.dart';
import 'utils/analytics.dart';
import 'utils/debug.dart';

class TasteApp extends StatefulWidget {
  const TasteApp();

  @override
  _TasteAppState createState() => _TasteAppState();
}

class _TasteAppState extends State<TasteApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Future.wait([
          "assets/ui/nav_home_active.png",
          "assets/ui/nav_home.png",
          "assets/ui/nav_search_active.png",
          "assets/ui/nav_search.png",
          "assets/ui/nav_camera.png",
          "assets/ui/nav_camera_active.png",
          "assets/ui/nav_map.png",
          "assets/ui/nav_map_active.png",
          "assets/ui/nav_social.png",
          "assets/ui/nav_social_active.png",
          "assets/ui/badge_icon.png",
          "assets/ui/delivery.png",
          "assets/ui/black_power.png",
        ].map((a) => precacheImage(AssetImage(a), context))));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: kTasteTheme,
        debugShowCheckedModeBanner: false,
        navigatorObservers: navigatorObservers(TasteNavigatorType.base),
        home: const _Home());
  }
}

final rootScaffoldKey = GlobalKey<ScaffoldState>();

class _Home extends StatelessWidget {
  const _Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [isLoadingProvider, experimentsProvider],
        child: Builder(
          builder: (context) => WillPopScope(
            onWillPop: () async => !await activeNav.maybePop(),
            child: Scaffold(
              key: rootScaffoldKey,
              body: RootLoadingWidget(
                child: MultiProvider(
                  providers: [
                    BlocProvider<FoodFinderManager>(
                        create: (context) => FoodFinderManager(), lazy: false),
                    Provider<_Inset>.value(
                        value: _Inset(MediaQuery.of(context).viewInsets)),
                    tasteDebugModeProvider,
                    StreamProvider.value(
                      value: KeyboardVisibility.onChange.map(
                        (s) => _KeyboardVisibile(s),
                      ),
                    ),
                    StreamProvider.value(value: navVisible.stream),
                  ],
                  child: const LoginPage(),
                ),
              ),
            ),
          ),
        ),
      );
}

final navVisible = BehaviorSubject.seeded(const NavVisible(true));

class NavVisible {
  const NavVisible(this.visible);
  final bool visible;
}

class _KeyboardVisibile {
  _KeyboardVisibile(this.visible);
  final bool visible;
}

bool isNavVisible(BuildContext c) =>
    Provider.of<NavVisible>(c)?.visible ?? true;

bool isKeyboardVisible(BuildContext c) =>
    Provider.of<_KeyboardVisibile>(c)?.visible ?? false;

class _Inset {
  const _Inset(this.insets);
  final EdgeInsets insets;
}

class ViewInsetted extends StatelessWidget {
  const ViewInsetted({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) =>
      Padding(padding: Provider.of<_Inset>(context).insets, child: child);
}
