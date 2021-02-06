import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:taste/screens/create_review/take_photo.dart';
import 'package:taste/screens/discover/discover.dart';
import 'package:taste/screens/food_finder/food_finder.dart';
import 'package:taste/screens/logged_in/logged_in.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/proto_transforms.dart';
import 'package:taste/utils/quick_stateful_widget.dart';

import '../../taste_app.dart';
import '../icons.dart';

class _NavItem {
  const _NavItem({this.tab, this.icon, this.widget});
  final TATab tab;
  final IconData icon;
  final Widget widget;

  BottomNavigationBarItem get barItem => BottomNavigationBarItem(
        icon: NavIcon(icon),
        title: Container(),
        activeIcon: NavIcon(icon, true),
      );
}

final _navBarKey = GlobalKey(debugLabel: 'NavBar');
final _index = ValueNotifier(0);
final _navKey = GlobalKey<NavigatorState>(debugLabel: 'nav');
typedef TabTapListener = FutureOr<bool> Function(int index);
final _listeners = <TabTapListener>[];

const _navItems = [
  _NavItem(
    tab: TATab.discover_tab,
    icon: Icons.menu,
    widget: DiscoverPage(),
  ),
  _NavItem(
    tab: TATab.create_tab,
    icon: AddIcon.add,
    widget: TakePhotoPage(),
  ),
  _NavItem(
    tab: TATab.profile_tab,
    icon: ProfileIcon.profile,
    widget: HomeUserWidget(),
  ),
];

TAPage get currentTabPage => _navItems[_index?.value ?? 0]?.tab?.page;

class TabbedPage extends StatelessWidget {
  const TabbedPage();
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
        valueListenable: _index,
        builder: (context, page, child) {
          return Scaffold(
            bottomNavigationBar:
                isKeyboardVisible(context) || !isNavVisible(context)
                    ? null
                    : BottomNavigationBar(
                        key: _navBarKey,
                        currentIndex: page,
                        onTap: (index) async {
                          TAEvent.nav_item_tap({
                            'index': index,
                            'title': _navItems[index].tab.name,
                          });
                          for (final listener in _listeners) {
                            if (!await listener(index)) {
                              return;
                            }
                          }
                          await goToTab(index);
                        },
                        items: _navItems.listMap((navItem) => navItem.barItem),
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.black,
                        unselectedItemColor: Colors.black.withOpacity(0.85),
                        backgroundColor: const Color(0xFFF4F4F4),
                      ),
            body: child,
          );
        },
        child: ValueListenableBuilder<int>(
            valueListenable: _index,
            builder: (context, _, __) {
              return Navigator(
                key: _navKey,
                observers: navigatorObservers(TasteNavigatorType.logged_in),
                onGenerateRoute: (s) => MaterialPageRoute(
                  settings: s,
                  builder: (_) => _navItems[_index.value].widget,
                ),
              );
            }),
      );
}

ScaffoldState get activeScaffold => _navKey.currentContext == null
    ? rootScaffoldKey.currentState
    : Scaffold.of(_navKey.currentContext);
NavigatorState get activeNav => _navKey.currentContext == null
    ? Navigator.of(rootScaffoldKey.currentState.context)
    : _navKey.currentState;

final _retap = BehaviorSubject<int>();

final onTabRetap = _retap.listen;
Future goToTab(int index) async {
  if (index < 0 || index >= _navItems.length) {
    return;
  }
  final switched = index != _index.value;
  var popped = false;
  _navKey.currentState.popUntil((p) {
    final value = p.isFirst;
    popped |= !value;
    return value;
  });
  if (!popped && !switched) {
    _retap.add(index);
  }
  _index.value = index;

  if (switched) {
    await analytics.setCurrentScreen(screenName: currentTabPage?.name ?? '');
  }
}

void hideNavBar() {
  navVisible.add(const NavVisible(false));
}

void showNavBar() {
  navVisible.add(const NavVisible(true));
}

class TabAwareWillPopScope extends StatelessWidget {
  const TabAwareWillPopScope(
      {Key key, @required this.onWillPop, @required this.child})
      : super(key: key);
  final TabTapListener onWillPop;
  final Widget child;

  @override
  Widget build(BuildContext context) => QuickStatefulWidget(
      initState: (s) {
        _listeners.add(onWillPop);
        s.defer(() => _listeners.remove(onWillPop));
      },
      builder: (_, __) => WillPopScope(
            onWillPop: () async => onWillPop(null),
            child: child,
          ));
}

TAPage get currentPage {
  TAPage current;
  activeNav.popUntil((route) {
    current = route.isFirst
        ? currentTabPage
        : route.settings?.arguments is TAPage
            ? route.settings.arguments as TAPage
            : enumFromString(route.settings.name, TAPage.values);
    return true;
  });
  return current;
}

extension TATabExtension on TATab {
  int get tabIndex => _navItems.indexWhere((i) => i.tab == this);
}
