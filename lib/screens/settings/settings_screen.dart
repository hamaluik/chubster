import 'package:chubster/blocs/settings/bloc.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsRepository settingsRepository =
        RepositoryProvider.of<SettingsRepository>(context);
    assert(settingsRepository != null);

    return BlocProvider<SettingsBloc>(
        create: (_) => SettingsBloc(settingsRepository),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final SettingsBloc settings =
                BlocProvider.of<SettingsBloc>(context);

            String bodyWeightUnits;
            switch (state.bodyWeightUnits) {
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
            switch (state.energyUnits) {
              case EnergyUnits.KCal:
                energyUnits = "KCal";
                break;
              case EnergyUnits.KJ:
                energyUnits = "KJ";
                break;
            }

            return ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Text("Units",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Body Weight"),
                      subtitle: Text(bodyWeightUnits),
                      leading: Icon(FontAwesomeIcons.weight),
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile<BodyWeightUnits>(
                                    title: const Text('lbs'),
                                    activeColor: Theme.of(context).accentColor,
                                    value: BodyWeightUnits.lbs,
                                    groupValue: state.bodyWeightUnits,
                                    onChanged: (BodyWeightUnits value) {
                                      settings.add(ChangeWeightUnits(value));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<BodyWeightUnits>(
                                    title: const Text('kgs'),
                                    activeColor: Theme.of(context).accentColor,
                                    value: BodyWeightUnits.kgs,
                                    groupValue: state.bodyWeightUnits,
                                    onChanged: (BodyWeightUnits value) {
                                      settings.add(ChangeWeightUnits(value));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<BodyWeightUnits>(
                                    title: const Text('stone'),
                                    activeColor: Theme.of(context).accentColor,
                                    value: BodyWeightUnits.stone,
                                    groupValue: state.bodyWeightUnits,
                                    onChanged: (BodyWeightUnits value) {
                                      settings.add(ChangeWeightUnits(value));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Energy"),
                      subtitle: Text(energyUnits),
                      leading: Icon(FontAwesomeIcons.bolt),
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile<EnergyUnits>(
                                    title: const Text('KCal'),
                                    activeColor: Theme.of(context).accentColor,
                                    value: EnergyUnits.KCal,
                                    groupValue: state.energyUnits,
                                    onChanged: (EnergyUnits value) {
                                      settings.add(ChangeEnergyUnits(value));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<EnergyUnits>(
                                    title: const Text('KJ'),
                                    activeColor: Theme.of(context).accentColor,
                                    value: EnergyUnits.KJ,
                                    groupValue: state.energyUnits,
                                    onChanged: (EnergyUnits value) {
                                      settings.add(ChangeEnergyUnits(value));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )),
                    )),
              ],
            );
          },
        ));
  }
}
