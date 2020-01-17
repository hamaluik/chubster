import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chubster/models/food.dart';
import 'package:chubster/repositories/localdb/localdb_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class FoodsScreenBloc extends Bloc<FoodsScreenEvent, FoodsScreenState> {
  final BuildContext context;

  FoodsScreenBloc(this.context);

  @override
  FoodsScreenState get initialState => FoodsScreenState.initial();

  @override
  Stream<FoodsScreenState> mapEventToState(
    FoodsScreenEvent event,
  ) async* {
    if(event is SearchUpdatedEvent) {
      print('searching for ${event.searchTerm}');
      List<Food> matchingFoods = await RepositoryProvider.of<LocalDBRepository>(context).searchForFoodByName(event.searchTerm);
      print('found ${matchingFoods.length} results');
      yield FoodsScreenState(event.searchTerm, matchingFoods);
    }
  }
}
