import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/blocs/settings/settings_bloc.dart';
import 'package:chubster/blocs/settings/settings_event.dart';
import 'package:chubster/repositories/foods_repository.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:chubster/repositories/settings_repository.dart';
import 'package:chubster/screens/foods/foods_screen.dart';
import 'package:chubster/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'blocs/theme/bloc.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() async {
  //BlocSupervisor.delegate = LogBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  final FoodsRepository foods = await FoodsRepository.open();
  final SettingsRepository settings = await SettingsRepository.load();
  final ProfileRepository profile = await ProfileRepository.open();

  assert(foods != null);
  assert(settings != null);
  assert(profile != null);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
      ),
      BlocProvider<SettingsBloc>(
        create: (_) => SettingsBloc(settings),
      ),
      BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(profile),
      ),
    ],
    child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) =>
          _ChubsterApp(foods: foods, settings: settings, profile: profile),
    ),
  ));
}

/// Chubster app is stateful so it can listen to platform brightness changes
/// using `WidgetsBindingObserver`
class _ChubsterApp extends StatefulWidget {
  final FoodsRepository foods;
  final ProfileRepository profile;
  final SettingsRepository settings;
  const _ChubsterApp({Key key, @required this.foods, @required this.settings, this.profile})
      : assert(foods != null),
        assert(settings != null),
        assert(profile != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ChubsterAppState();
}

enum Screen { dashboard, stats, log, foods, profile }

class _ChubsterAppState extends State<_ChubsterApp>
    with WidgetsBindingObserver {
  Screen _currentScreen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentScreen = Screen.dashboard;
    BlocProvider.of<SettingsBloc>(context).add(LoadSettingsFromRepository());
    BlocProvider.of<ProfileBloc>(context).add(LoadProfileFromRepository());
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
    Widget body;
    switch(_currentScreen) {
      case Screen.dashboard:
        body = DashboardScreen();
        break;
      case Screen.stats:
        body = Container();
        break;
      case Screen.log:
        body = Container();
        break;
      case Screen.foods:
        body = FoodsScreen();
        break;
      case Screen.profile:
        body = ProfileScreen();
        break;
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FoodsRepository>.value(value: widget.foods),
        RepositoryProvider<SettingsRepository>.value(value: widget.settings),
        RepositoryProvider<ProfileRepository>.value(value: widget.profile),
      ],
      child: MaterialApp(
        title: 'Chubster',
        theme: BlocProvider.of<ThemeBloc>(context).state.theme,
        home: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: body,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentScreen.index,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), title: Text("Dashboard"), backgroundColor: BlocProvider.of<ThemeBloc>(context).state.theme.accentColor),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.chartLine), title: Text("Stats"), backgroundColor: BlocProvider.of<ThemeBloc>(context).state.theme.accentColor),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.cookieBite), title: Text("Log"), backgroundColor: BlocProvider.of<ThemeBloc>(context).state.theme.accentColor),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.carrot), title: Text("Foods"), backgroundColor: BlocProvider.of<ThemeBloc>(context).state.theme.accentColor),
              BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAstronaut), title: Text("Profile"), backgroundColor: BlocProvider.of<ThemeBloc>(context).state.theme.accentColor),
            ],
            onTap: (index) => setState(() {
              _currentScreen = Screen.values[index];
            })
          ),
        ),
      )
    );
  }
}
