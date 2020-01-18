import 'package:chubster/components/navbar.dart';
import 'package:chubster/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'bloc/bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsRepository settingsRepository = RepositoryProvider.of<SettingsRepository>(context);
    assert(settingsRepository != null);

    return BlocProvider<SettingsBloc>(
        create: (_) => SettingsBloc(settingsRepository),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Settings"),
            ),
            body: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                final SettingsBloc settings = BlocProvider.of<SettingsBloc>(context);

                String bodyWeightUnits;
                switch(state.bodyWeightUnits) {
                  case BodyWeightUnits.lbs:
                    bodyWeightUnits = "lbs";
                    break;
                  case BodyWeightUnits.kgs:
                    bodyWeightUnits = "kgs";
                    break;
                  case BodyWeightUnits.stone:
                    bodyWeightUnits = "stone";
                    break;
                }

                String energyUnits;
                switch(state.energyUnits) {
                  case EnergyUnits.KCal:
                    energyUnits = "KCal";
                    break;
                  case EnergyUnits.KJ:
                    energyUnits = "KJ";
                    break;
                }

                return SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'Default Units',
                      tiles: [
                        SettingsTile(
                          title: 'Body Weight',
                          subtitle: bodyWeightUnits,
                          leading: Icon(FontAwesomeIcons.weight),
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RadioListTile<BodyWeightUnits>(
                                  title: const Text('lbs'),
                                  value: BodyWeightUnits.lbs,
                                  groupValue: state.bodyWeightUnits,
                                  onChanged: (BodyWeightUnits value) {
                                    settings.add(ChangeWeightUnits(value));
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<BodyWeightUnits>(
                                  title: const Text('kgs'),
                                  value: BodyWeightUnits.kgs,
                                  groupValue: state.bodyWeightUnits,
                                  onChanged: (BodyWeightUnits value) {
                                    settings.add(ChangeWeightUnits(value));
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<BodyWeightUnits>(
                                  title: const Text('stone'),
                                  value: BodyWeightUnits.stone,
                                  groupValue: state.bodyWeightUnits,
                                  onChanged: (BodyWeightUnits value) {
                                    settings.add(ChangeWeightUnits(value));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                          ),
                        ),
                        SettingsTile(
                          title: 'Food Energy',
                          subtitle: energyUnits,
                          leading: Icon(FontAwesomeIcons.bolt),
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RadioListTile<EnergyUnits>(
                                  title: const Text('KCal'),
                                  value: EnergyUnits.KCal,
                                  groupValue: state.energyUnits,
                                  onChanged: (EnergyUnits value) {
                                    settings.add(ChangeEnergyUnits(value));
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile<EnergyUnits>(
                                  title: const Text('KJ'),
                                  value: EnergyUnits.KJ,
                                  groupValue: state.energyUnits,
                                  onChanged: (EnergyUnits value) {
                                    settings.add(ChangeEnergyUnits(value));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: NavBar(
              screen: Screen.settings,
            ),));
  }
}
