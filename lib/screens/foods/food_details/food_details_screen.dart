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
            Text(food.name, style: Theme.of(context).textTheme.title),
            Text("Energy: ${food.energy ?? '?'} kCal", style: Theme.of(context).textTheme.subtitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(flex: 3, child: Container()),
                Expanded(
                  flex: 1,
                  child: Text("/ 100 g", textAlign: TextAlign.right,)
                ),
                Expanded(
                  flex: 1,
                  child: Text("% Daily", textAlign: TextAlign.right,),
                )
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text("Total Fat", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fatTotal ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fatTotal, multiplier, 65), style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Monounsaturated"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fatMonounsaturated?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fatMonounsaturated, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Polyunsaturated"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fatPolyunsaturated?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fatPolyunsaturated, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Saturated"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fatSaturated?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fatSaturated, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Transaturated"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fatTransaturated?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fatTransaturated, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text("Carbohydrate", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.carbohydrates ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.carbohydrates, multiplier, 65), style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Fibre"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.fiber?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.fiber, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Sugars"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.sugars?.toStringAsFixed(1) ?? '?'} g", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.sugars, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text("Protein", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.protein ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.protein, multiplier, 65), style: TextStyle(fontWeight: FontWeight.w700), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Divider(thickness: 2.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Cholesterol"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.cholesterol?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.cholesterol, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Sodium"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.sodium?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.sodium, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Potassium"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.potassium?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.potassium, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Calcium"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.calcium?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.calcium, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Iron"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.iron?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.iron, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Divider(thickness: 2.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Caffeine"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.caffeine?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.caffeine, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text("Alcohol"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text("${food.alcohol?.toStringAsFixed(1) ?? '?'} mg", textAlign: TextAlign.right,),
                ),
                Expanded(
                  flex: 1,
                  child: Text(renderDailyValue(food.alcohol, multiplier, null), textAlign: TextAlign.right,),
                ),
              ],
            ),
            Divider(thickness: 2.0, color: Theme.of(context).textTheme.body1.color),
          ],
        )
      )
    );
  }
}