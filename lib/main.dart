import 'package:chubster/log_bloc_delegate.dart';
import 'package:chubster/repositories/localdb_repository.dart';
import 'package:chubster/repositories/settings_repository.dart';
import 'package:chubster/screens/foods/bloc/foods_bloc.dart';
import 'package:chubster/screens/foods/foods_screen.dart';
import 'package:chubster/screens/settings/bloc/bloc.dart';
import 'package:chubster/screens/settings/settings_screen.dart';
import 'package:chubster/themes.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'blocs/theme/bloc.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() async {
  BlocSupervisor.delegate = LogBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  final LocalDBRepository localDB = await LocalDBRepository.open();
  final SettingsRepository settings = SettingsRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
      )
    ],
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) =>
          _ChubsterApp(localDB: localDB, settings: settings),
    ),
  ));
}

/// Chubster app is stateful so it can listen to platform brightness changes
/// using `WidgetsBindingObserver`
class _ChubsterApp extends StatefulWidget {
  final LocalDBRepository localDB;
  final SettingsRepository settings;
  const _ChubsterApp({Key key, @required this.localDB, @required this.settings})
      : assert(localDB != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ChubsterAppState();
}

enum Screen { dashboard, foods, settings }

class _ChubsterAppState extends State<_ChubsterApp>
    with WidgetsBindingObserver {
  Screen _currentScreen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentScreen = Screen.dashboard;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    BlocProvider.of<ThemeBloc>(context)
        .add(BrightnessChanged(brightness: brightness));
  }

  @override
  Widget build(BuildContext context) {
    Widget title;
    Widget body;
    switch(_currentScreen) {
      case Screen.dashboard:
        title = Text("Dashboard");
        body = DashboardScreen();
        break;
      case Screen.foods:
        title = Text("Foods");
        body = FoodsScreen();
        break;
      case Screen.settings:
        title = Text("Settings");
        body = SettingsScreen();
        break;
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalDBRepository>.value(value: widget.localDB),
        RepositoryProvider<SettingsRepository>.value(value: widget.settings),
      ],
      child: MaterialApp(
        title: 'Chubster',
        theme: BlocProvider.of<ThemeBloc>(context).state.theme,
        darkTheme: darkTheme,
        home: Scaffold(
          appBar: AppBar(
            title: title,
          ),
          body: body,
          bottomNavigationBar: FancyBottomNavigation(
            initialSelection: _currentScreen.index,
            tabs: [
              TabData(iconData: FontAwesomeIcons.home, title: "Dasboard"),
              TabData(iconData: FontAwesomeIcons.carrot, title: "Foods"),
              TabData(iconData: FontAwesomeIcons.cogs, title: "Settings")
            ],
            onTabChangedListener: (position) => setState(() {
              _currentScreen = Screen.values[position];
            })
          ),
        ),
      )
    );
  }
}
