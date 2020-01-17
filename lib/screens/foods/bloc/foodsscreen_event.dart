import 'package:equatable/equatable.dart';

abstract class FoodsScreenEvent extends Equatable {
  const FoodsScreenEvent();
}

class SearchUpdatedEvent extends FoodsScreenEvent {
  final String searchTerm;

  SearchUpdatedEvent(this.searchTerm);

  @override List<Object> get props => [searchTerm];
}
