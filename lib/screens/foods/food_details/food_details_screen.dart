import 'package:chubster/blocs/profile/bloc.dart';
import 'package:chubster/models/food.dart';
import 'package:chubster/models/activity_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;
  const FoodDetailsScreen({Key key, this.food}) : assert(food != null), super(key: key);

  static String renderDailyValue(double value, double multiplier, double reference) {
    if(value == null || reference == null || reference == 0.0) return "";
    return (100.0 * multiplier * value / reference).toStringAsFixed(0) + " %";
  }

  @override
  Widget build(BuildContext context) {
    final ProfileBloc profile = BlocProvider.of<ProfileBloc>(context);
    assert(profile != null);
    double tdee = profile.state.totalDailyEnergy ?? 2000.0;
    double multiplier = tdee / 2000.0;

    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text("Nutrition Facts", style: TextStyle(
              color: Theme.of(context).textTheme.body1.color,
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.display1.fontSize,
            )),
            Text("Energy: ${food.energy ?? '?'} kCal", style: TextStyle(fontWeight: FontWeight.w700)),
            Text("Nutritional content / 100 g"),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("% Daily", style: Theme.of(context).textTheme.caption)
              ],
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total Fat: ${food.fatTotal ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text(renderDailyValue(food.fatTotal, multiplier, 65), style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Monounsaturated: ${food.fatMonounsaturated ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.fatMonounsaturated, multiplier, null)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Polyunsaturated: ${food.fatPolyunsaturated ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.fatPolyunsaturated, multiplier, null)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Saturated: ${food.fatSaturated ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.fatSaturated, multiplier, 20)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Transaturated: ${food.fatTransaturated ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.fatTransaturated, multiplier, 0)),
                ],
              ),
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Carbohydrate: ${food.carbohydrates ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text(renderDailyValue(food.carbohydrates, multiplier, 300), style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Fibre: ${food.fiber ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.fiber, multiplier, 25)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Sugars: ${food.sugars ?? '?'} g", style: TextStyle()),
                  Text(renderDailyValue(food.sugars, multiplier, null)),
                ],
              ),
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Protein: ${food.protein ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text(renderDailyValue(food.protein, multiplier, null), style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Cholesterol: ${food.cholesterol ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.cholesterol, multiplier, 300)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Sodium: ${food.sodium ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.sodium, multiplier, 2400)),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Potassium: ${food.potassium ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.potassium, multiplier, null)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Calcium: ${food.calcium ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.calcium, multiplier, 1100)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Iron: ${food.iron ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.iron, multiplier, 14)),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Caffeine: ${food.caffeine ?? '?'} mg", style: TextStyle()),
                Text(renderDailyValue(food.caffeine, multiplier, null)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Alcohol: ${food.alcohol ?? '?'} mg", style: TextStyle()),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
          ],
        )
      )
    );
  }
}