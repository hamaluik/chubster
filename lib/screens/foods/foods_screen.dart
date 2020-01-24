import 'package:chubster/repositories/foods_repository.dart';
import 'package:chubster/screens/foods/food_details/food_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'bloc/bloc.dart';

class FoodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FoodsRepository foods =
        RepositoryProvider.of<FoodsRepository>(context);
    assert(foods != null);

    return BlocProvider<FoodsBloc>(
      create: (_) => FoodsBloc(foods),
        child: Container(
          child: Column(
          children: <Widget>[
            _SearchResults(),
            _SearchBar(),
          ],
        )
      )
    );
  }
}

class _SearchBar extends StatefulWidget {
  _SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");
  }

  void _updateSearch(FoodsBloc bloc, String searchTerm) {
    bloc.add(SearchTermChangedEvent(searchTerm));
  }

  @override
  Widget build(BuildContext context) {
    final FoodsBloc foodsBloc = BlocProvider.of<FoodsBloc>(context);
    String label;
    if(foodsBloc.state is EmptyFoodsState) {
      label = "Search for foods by name";
    }
    String error;
    if(foodsBloc.state is SearchingFoodsError) {
      error = "Error searching databases!";
    }

    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      child: 
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: TextField(
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(
              icon: Icon(FontAwesomeIcons.search),
              hintText: label,
              errorText: error,
            ),
            controller: _textController,
            onChanged: (searchTerm) =>
                Debounce.milliseconds(100, _updateSearch, [foodsBloc, searchTerm]),
            onSubmitted: (searchTerm) =>
                Debounce.runAndClear(_updateSearch, [foodsBloc, searchTerm]),
          ),
        ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      builder: (context, state) {
        if (state is SearchingFoodsState) {
          return Center(
              child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: LoadingIndicator(
                    indicatorType: Indicator.pacman,
                  )));
        } else if (state is SearchResultsFoodsState) {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: state.foods.map((food) {
                return ListTile(
                  title: Text(food.name),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FoodDetailsScreen(
                      food: food,
                    ),
                  )),
                );
              }).toList(),
            ),
          );
        } else {
          return Expanded(
            child: Container()
          );
        }
      },
    );
  }
}
