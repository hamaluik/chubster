import 'package:chubster/components/route_transitions.dart';
import 'package:chubster/screens/dashboard/dashboard_screen.dart';
import 'package:chubster/screens/foods/foods_screen.dart';
import 'package:chubster/screens/settings/settings_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Screen { dashboard, foods, settings }

class NavBar extends StatelessWidget {
  final Screen screen;
  const NavBar({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyBottomNavigation(
      initialSelection: screen.index,
      tabs: [
        TabData(iconData: FontAwesomeIcons.home, title: "Dasboard"),
        TabData(iconData: FontAwesomeIcons.carrot, title: "Foods"),
        TabData(iconData: FontAwesomeIcons.cogs, title: "Settings")
      ],
      onTabChangedListener: (position) {
        Screen newScreen = Screen.values[position];
        if (screen == newScreen) {
          return;
        }

        switch (Screen.values[position]) {
          case Screen.dashboard:
            {
              Navigator.pushReplacement(context, SlideRightRoute(page: DashboardScreen()));
              break;
            }
          case Screen.foods:
            {
              if (position >= screen.index) {
                Navigator.pushReplacement(context, SlideLeftRoute(page: FoodsScreen()));
              } else {
                Navigator.pushReplacement(context, SlideRightRoute(page: FoodsScreen()));
              }
              break;
            }
          case Screen.settings:
            {
              if (position >= screen.index) {
                Navigator.pushReplacement(context, SlideLeftRoute(page: SettingsScreen()));
              } else {
                Navigator.pushReplacement(
                    context, SlideRightRoute(page: SettingsScreen()));
              }
              break;
            }
        }
      },
    );
  }
}
