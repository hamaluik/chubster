import 'package:chubster/components/navbar.dart';
import 'package:chubster/screens/foods/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FoodsScreenState();
}

class FoodsScreenState extends State<FoodsScreen> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Foods"),
        ),
        body: BlocProvider(
          create: (context) => FoodsScreenBloc(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    icon: Icon(FontAwesomeIcons.search),
                    hintText: 'food name',
                  ),
                  onChanged: (searchTerm) => {},
                ),
              ),
              SizedBox(height: 20.0),
              BlocBuilder<FoodsScreenBloc, FoodsScreenState>(
                builder: (context, blocState) {
                  return blocState.matchingFoods != null && blocState.matchingFoods.length != 0
                  ? Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(10.0),
                        children: blocState.matchingFoods.map((food) {
                          return ListTile(title: Text(food.name));
                        }).toList(),
                      ),
                    )
                  : SizedBox();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavBar(
          screen: Screen.foods,
        ));
  }
}
