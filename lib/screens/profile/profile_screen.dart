import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_debounce_it/just_debounce_it.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileRepository profileRepository =
        RepositoryProvider.of<ProfileRepository>(context);
    assert(profileRepository != null);

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profile) {
        final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);

        IconData sexIcon;
        switch (profile.sex) {
          case Sex.male:
            sexIcon = FontAwesomeIcons.male;
            break;
          case Sex.female:
            sexIcon = FontAwesomeIcons.female;
            break;
          case Sex.other:
            sexIcon = FontAwesomeIcons.genderless;
            break;
        }

        return ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Text("Profile",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800)),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("Sex"),
                  trailing: Text(profile.sex.stringify),
                  leading: Icon(sexIcon),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RadioListTile<Sex>(
                                title: Text(Sex.male.stringify),
                                value: Sex.male,
                                groupValue: profile.sex,
                                onChanged: (Sex value) {
                                  profileBloc.add(ChangeSex(Sex.male));
                                  Navigator.pop(context);
                                },
                              ),
                              RadioListTile<Sex>(
                                title: Text(Sex.female.stringify),
                                value: Sex.female,
                                groupValue: profile.sex,
                                onChanged: (Sex value) {
                                  profileBloc.add(ChangeSex(Sex.female));
                                  Navigator.pop(context);
                                },
                              ),
                              RadioListTile<Sex>(
                                title: Text(Sex.other.stringify),
                                value: Sex.other,
                                groupValue: profile.sex,
                                onChanged: (Sex value) {
                                  profileBloc.add(ChangeSex(Sex.other));
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("Height"),
                  trailing: profile.height != null
                      ? Text(profile.height.value.toStringAsFixed(2) +
                          " " +
                          profile.height.unitsStr)
                      : Text("—"),
                  leading: Icon(FontAwesomeIcons.ruler),
                  onTap: () => showModalBottomSheet(
                      context: context, builder: (context) => HeightsSheet()),
                )),
          ],
        );
      },
    );
  }
}

class HeightsSheet extends StatefulWidget {
  HeightsSheet({Key key}) : super(key: key);

  @override
  _HeightsSheetState createState() => _HeightsSheetState();
}

class _HeightsSheetState extends State<HeightsSheet> {
  ScrollController _scaleController;
  int feet;
  int inches;
  CentiMeters cm;

  @override
  void initState() {
    _scaleController = ScrollController();
    feet = 0;
    inches = 0;
    cm = CentiMeters(0);
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  void _setHeight() {
    Meters newHeight = cm.toMeters();
    BlocProvider.of<ProfileBloc>(context).add(SetHeight(newHeight));
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Height:", style: Theme.of(context).textTheme.title),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text("$feet ft $inches in"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text("${cm.value.toStringAsFixed(1)} ${cm.unitsStr}"),
                ),
              ],
            ),
          ),
        ),
        VerticalScale(
          maxValue: 8,
          linesBetweenTwoPoints: 11,
          middleLineAt: 6,
          scaleColor: Theme.of(context).accentColor,
          lineColor: Colors.white,
          scaleController: _scaleController,
          pointer: Container(
            height: 3,
            width: 90,
            decoration:
                BoxDecoration(color: Colors.redAccent.withOpacity(0.7)),
          ),
          onChanged: (int scalePoints) {
            int inchOffest = scalePoints ~/ 20;
            Feet newHeightFeet = Feet(feet + inches.toDouble() / 12.0);
            Meters newHeight = newHeightFeet.toMeters();
            setState(() {
              feet = inchOffest ~/ 12;
              inches = inchOffest % 12;
              cm = newHeight.toCentiMeters();
            });
            _setHeight();
          },
        )
      ],
    );
  }
}
