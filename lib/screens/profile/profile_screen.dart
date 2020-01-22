import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
                  title: Text("Birthday"),
                  subtitle: Text(new DateFormat.yMMMd().format(profile.birthday)),
                  trailing: Icon(FontAwesomeIcons.chevronRight),
                  leading: Icon(FontAwesomeIcons.birthdayCake),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: profile.birthday,
                      firstDate: DateTime.now().subtract(Duration(days: (365.25 * 80).floor())),
                      lastDate: DateTime(DateTime.now().year),
                    )
                    .then((DateTime newBirthday) => profileBloc.add(SetBirthday(newBirthday)));
                  },
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("Sex"),
                  subtitle: Text(profile.sex.stringify),
                  trailing: Icon(FontAwesomeIcons.chevronRight),
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
                  subtitle: profile.height != null
                      ? Text(profile.height.value.toStringAsFixed(2) +
                          " " +
                          profile.height.unitsStr)
                      : Text("—"),
                  trailing: Icon(FontAwesomeIcons.chevronRight),
                  leading: Icon(FontAwesomeIcons.ruler),
                  onTap: () => showModalBottomSheet(
                      context: context, builder: (context) => HeightsSheet()),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("Weight"),
                  subtitle: profile.weight != null
                      ? Text(profile.weight.value.toStringAsFixed(1) +
                          " " +
                          profile.weight.unitsStr)
                      : Text("—"),
                  trailing: Icon(FontAwesomeIcons.chevronRight),
                  leading: Icon(FontAwesomeIcons.weight),
                  onTap: () => showModalBottomSheet(
                      context: context, builder: (context) => WeightSheet()).then((_) => profileBloc.add(RecordWeight())),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("BMI"),
                  subtitle: profile.bmi != null
                      ? Text(profile.bmi.toStringAsFixed(1))
                      : Text("—"),
                  leading: Icon(FontAwesomeIcons.user),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                child: ListTile(
                  title: Text("Body Fat"),
                  subtitle: profile.bodyFatPercent != null
                      ? Text("Estimated " + profile.bodyFatPercent.toStringAsFixed(0) + "%")
                      : Text("—"),
                  leading: Icon(FontAwesomeIcons.percentage),
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

class WeightSheet extends StatefulWidget {
  WeightSheet({Key key}) : super(key: key);

  @override
  _WeightSheetState createState() => _WeightSheetState();
}

class _WeightSheetState extends State<WeightSheet> {
  ScrollController _scaleController;
  Lbs lbs;

  @override
  void initState() {
    WeightUnits startWeight = BlocProvider.of<ProfileBloc>(context).state.weight;
    if(startWeight == null) startWeight = Lbs(200);

    _scaleController = ScrollController(initialScrollOffset: (200 * startWeight.toLbs().value).toDouble());
    lbs = startWeight.toLbs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Weight", style: Theme.of(context).textTheme.title),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("${lbs.value.toStringAsFixed(1)} ${lbs.unitsStr}"),
                )
              ],
            )
          )
        ),
        HorizontalScale(
          maxValue: 400,
          linesBetweenTwoPoints: 9,
          middleLineAt: 5,
          scaleColor: Theme.of(context).accentColor,
          lineColor: Colors.white,
          scaleController: _scaleController,
          onChanged: (int scalePoints) {
            setState(() {
              int tenTimesLbs = scalePoints ~/ 20;
              lbs = Lbs(tenTimesLbs.toDouble() / 10.0);
              BlocProvider.of<ProfileBloc>(context).add(SetWeight(lbs));
            });
          }
        ),
      ],
    );
  }
}