import 'package:chubster/models/food.dart';
import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;
  const FoodDetailsScreen({Key key, this.food}) : assert(food != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Nutrition Facts", style: TextStyle(
              color: Theme.of(context).textTheme.body1.color,
              fontWeight: FontWeight.w700,
              fontSize: Theme.of(context).textTheme.display1.fontSize,
            )),
            Text("Energy ${food.energy ?? '?'}", style: TextStyle(fontWeight: FontWeight.w700)),
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
                Text("Total Fat ${food.fatTotal ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text("? %", style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Monounsaturated ${food.fatMonounsaturated ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Polyunsaturated ${food.fatPolyunsaturated ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Saturated ${food.fatSaturated ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Transaturated ${food.fatTransaturated ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Carbohydrate ${food.carbohydrates ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text("? %", style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Fibre ${food.fiber ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Sugars ${food.sugars ?? '?'} g", style: TextStyle()),
                  Text("? %"),
                ],
              ),
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Protein ${food.protein ?? '?'} g", style: TextStyle(fontWeight: FontWeight.w700)),
                Text("? %", style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            Divider(thickness: 1.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Cholesterol ${food.cholesterol ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Sodium ${food.sodium ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Potassium ${food.potassium ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Calcium ${food.calcium ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Iron ${food.iron ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Caffeine ${food.caffeine ?? '?'} mg", style: TextStyle()),
                Text("? %"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Alcohol ${food.alcohol ?? '?'} mg", style: TextStyle()),
              ],
            ),
            Divider(thickness: 4.0, color: Theme.of(context).textTheme.body1.color),
          ],
        )
      )
    );
  }
}