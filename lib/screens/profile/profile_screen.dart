import 'package:chubster/models/activity_level.dart';
import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/blocs/settings/bloc.dart';
import 'package:chubster/models/food_source.dart';
import 'package:chubster/models/sex.dart';
import 'package:chubster/models/units.dart';
import 'package:chubster/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale/flutter_scale.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        final SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);

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
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
              child: Text("Profile",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800)),
            ),
            Container(
              color: Theme.of(context).dialogBackgroundColor,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Birthday"),
                      subtitle: Text(new DateFormat.yMMMd().format(profile.birthday)),
                      trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).accentColor),
                      leading: Icon(FontAwesomeIcons.birthdayCake),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: profile.birthday,
                          firstDate: DateTime.now().subtract(Duration(days: (365.25 * 80).floor())),
                          lastDate: DateTime(DateTime.now().year),
                        )
                        .then((DateTime newBirthday) {
                          if(newBirthday != null) {
                            profileBloc.add(SetBirthday(newBirthday));
                          }
                        });
                      },
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Sex"),
                      subtitle: Text(profile.sex.stringify),
                      trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).accentColor),
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
                      trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).accentColor),
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
                      trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).accentColor),
                      leading: Icon(FontAwesomeIcons.weight),
                      onTap: () => showModalBottomSheet(
                          context: context, builder: (context) => WeightSheet()).then((_) => profileBloc.add(RecordWeight())),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Activity Level"),
                      subtitle: Text('${profile.activityLevel.stringify} (${profile.activityLevel.description})'),
                      trailing: Icon(FontAwesomeIcons.chevronRight, color: Theme.of(context).accentColor),
                      leading: Icon(FontAwesomeIcons.dumbbell),
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  RadioListTile<ActivityLevel>(
                                    title: Text(ActivityLevel.sedentary.stringify),
                                    subtitle: Text(ActivityLevel.sedentary.description),
                                    value: ActivityLevel.sedentary,
                                    groupValue: profile.activityLevel,
                                    onChanged: (ActivityLevel value) {
                                      profileBloc.add(ChangeActivityLevel(ActivityLevel.sedentary));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<ActivityLevel>(
                                    title: Text(ActivityLevel.light.stringify),
                                    subtitle: Text(ActivityLevel.light.description),
                                    value: ActivityLevel.light,
                                    groupValue: profile.activityLevel,
                                    onChanged: (ActivityLevel value) {
                                      profileBloc.add(ChangeActivityLevel(ActivityLevel.light));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<ActivityLevel>(
                                    title: Text(ActivityLevel.moderate.stringify),
                                    subtitle: Text(ActivityLevel.moderate.description),
                                    value: ActivityLevel.moderate,
                                    groupValue: profile.activityLevel,
                                    onChanged: (ActivityLevel value) {
                                      profileBloc.add(ChangeActivityLevel(ActivityLevel.moderate));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<ActivityLevel>(
                                    title: Text(ActivityLevel.very.stringify),
                                    subtitle: Text(ActivityLevel.very.description),
                                    value: ActivityLevel.very,
                                    groupValue: profile.activityLevel,
                                    onChanged: (ActivityLevel value) {
                                      profileBloc.add(ChangeActivityLevel(ActivityLevel.very));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  RadioListTile<ActivityLevel>(
                                    title: Text(ActivityLevel.extra.stringify),
                                    subtitle: Text(ActivityLevel.extra.description),
                                    value: ActivityLevel.extra,
                                    groupValue: profile.activityLevel,
                                    onChanged: (ActivityLevel value) {
                                      profileBloc.add(ChangeActivityLevel(ActivityLevel.extra));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )),
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
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Resting Energy / Day"),
                      subtitle: profile.restingDailyEnergy != null
                          ? Text("Estimated " + profile.restingDailyEnergy.toStringAsFixed(0) + " kCal")
                          : Text("—"),
                      leading: Icon(FontAwesomeIcons.bed),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                    child: ListTile(
                      title: Text("Total Energy / Day"),
                      subtitle: profile.totalDailyEnergy != null
                          ? Text("Estimated " + profile.totalDailyEnergy.toStringAsFixed(0) + " kCal")
                          : Text("—"),
                      leading: Icon(FontAwesomeIcons.fire),
                    )),
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
              child: Text("Food Databases",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800)),
            ),
            Container(
              color: Theme.of(context).dialogBackgroundColor,
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) => Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: ListTile(
                        title: Text("My Foods"),
                        trailing: Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: settingsState.localActive,
                          onChanged: (active) => settingsBloc.add(SetFoodsSourceEvent(FoodSource.local, active)),
                        ),
                        leading: Icon(FontAwesomeIcons.userAstronaut),
                        onTap: () => settingsBloc.add(ToggleFoodsSourceEvent(FoodSource.local)),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                      child: ListTile(
                        title: Text("Canadian Nutrient File"),
                        subtitle: new InkWell(
                          child: new Text(
                            'Canadian Nutrient File, Health Canada, 2015', 
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).textTheme.caption.decorationColor,
                              fontSize: Theme.of(context).textTheme.caption.fontSize,
                            )
                          ),
                          onTap: () => _launchURL('https://food-nutrition.canada.ca/cnf-fce/index-eng.jsp')
                        ),
                        trailing: Switch.adaptive(
                          activeColor: Theme.of(context).accentColor,
                          value: settingsState.cnfActive,
                          onChanged: (active) => settingsBloc.add(SetFoodsSourceEvent(FoodSource.cnf, active)),
                        ),
                        leading: Icon(FontAwesomeIcons.canadianMapleLeaf),
                        onTap: () => settingsBloc.add(ToggleFoodsSourceEvent(FoodSource.cnf)),
                      )
                    ),
                  ],
                ),
              )
            )
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      print('Could not launch $url');
    }
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