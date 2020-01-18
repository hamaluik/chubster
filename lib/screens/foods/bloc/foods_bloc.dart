import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chubster/models/food.dart';
import 'package:chubster/repositories/localdb_repository.dart';
import './bloc.dart';
import 'bloc.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final LocalDBRepository localDB;
  FoodsBloc(this.localDB) : assert(localDB != null) {
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
      print("searching...");
      yield SearchingFoodsState();
      try {
        List<Food> foods = await localDB.searchForFoodByName(event.searchTerm);
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
