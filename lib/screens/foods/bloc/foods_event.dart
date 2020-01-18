import 'package:equatable/equatable.dart';

abstract class FoodsEvent extends Equatable {
  const FoodsEvent();
}

class SearchTermChangedEvent extends FoodsEvent {
  final String searchTerm;
  SearchTermChangedEvent(this.searchTerm);

  @override List<Object> get props => [searchTerm];
}
