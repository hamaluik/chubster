import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/theme/bloc.dart';

void main() {
  runApp(
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
    BlocProvider.of<ThemeBloc>(context).add(BrightnessChanged(
        brightness: WidgetsBinding.instance.window.platformBrightness));
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
      home: Scaffold(
          appBar: AppBar(
            title: Text("Chubster"),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.plus_one),
            onPressed: () => BlocProvider.of<ThemeBloc>(context).add(
                BrightnessChanged(
                    brightness: BlocProvider.of<ThemeBloc>(context).state.brightness == Brightness.dark
                        ? Brightness.light
                        : Brightness.dark)),
          ),
          body: Center(
            child: Text("Hello world"),
          )),
    );
  }
}
