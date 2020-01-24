import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/repositories/foods_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chubster/models/food.dart';
import './bloc.dart';
import 'bloc.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final FoodsRepository foodsRepo;
  FoodsBloc(this.foodsRepo) : assert(foodsRepo != null) {
    print('created foods bloc');
  }

  @override
  FoodsState get initialState => EmptyFoodsState();

  @override
  Stream<FoodsState> mapEventToState(
    FoodsEvent event,
  ) async* {
    print("FoodsEvent received: " + event.toString());
    if(event is SearchTermChangedEvent) {
      if(event.searchTerm == null || event.searchTerm.trim().length < 1) {
        yield SearchResultsFoodsState([]);
      }
      else {
        print("searching...");
        yield SearchingFoodsState();
        try {
          List<Food> foods = await foodsRepo.searchForFoodByName(event.searchTerm, localActive: event.localActive, cnfActive: event.cnfActive);
          print('found ${foods.length} foods!');
          yield SearchResultsFoodsState(foods);
        }
        catch(_) {
          print('error!');
          yield SearchingFoodsError();
        }
        print('done _loadEvent');
      }
    }
  }
}
