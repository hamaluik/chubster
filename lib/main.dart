import 'package:chubster/repositories/localdb/localdb_repository.dart';
import 'package:chubster/screens/foods/foods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/bloc.dart';
import 'screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalDBRepository>(create: (BuildContext context) => LocalDBRepository.openSync())
      ],
      child: 
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (BuildContext context) => ThemeBloc(),
            )
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) => _ChubsterApp(),
          ),
        ),
    )
  );
}

/// Chubster app is stateful so it can listen to platform brightness changes
/// using `WidgetsBindingObserver`
class _ChubsterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChubsterAppState();
}

class _ChubsterAppState extends State<_ChubsterApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    return MaterialApp(
      title: 'Chubster',
      theme: BlocProvider.of<ThemeBloc>(context).state.theme,
      routes: {
        '/': (context) => DashboardScreen(),
        '/add': (context) => DashboardScreen(),
        '/foods': (context) => FoodsScreen(),
        '/settings': (context) => DashboardScreen(),
      },
      initialRoute: '/',
    );
  }
}
