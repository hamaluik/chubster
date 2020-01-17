import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Screen { dashboard, add, foods, settings }

class NavBar extends StatelessWidget {
  final Screen screen;
  const NavBar({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyBottomNavigation(
      initialSelection: screen.index,
      tabs: [
        TabData(iconData: FontAwesomeIcons.home, title: "Dasboard"),
        TabData(iconData: FontAwesomeIcons.cookieBite, title: "Add"),
        TabData(iconData: FontAwesomeIcons.carrot, title: "Foods"),
        TabData(iconData: FontAwesomeIcons.cogs, title: "Settings")
      ],
      onTabChangedListener: (position) {
        print('onTabChanged to $position, ${Screen.values[position]}');

        switch (Screen.values[position]) {
          case Screen.dashboard:
            Navigator.pushReplacementNamed(context, "/");
            break;
          case Screen.add:
            Navigator.pushReplacementNamed(context, "/add");
            break;
          case Screen.foods:
            Navigator.pushReplacementNamed(context, "/foods");
            break;
          case Screen.settings:
            Navigator.pushReplacementNamed(context, "/settings");
            break;
        }
      },
    );
  }
}
