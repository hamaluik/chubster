import 'package:equatable/equatable.dart';

abstract class FoodsEvent extends Equatable {
  const FoodsEvent();
}

class SearchTermChangedEvent extends FoodsEvent {
  final String searchTerm;
  final bool localActive;
  final bool cnfActive;
  SearchTermChangedEvent(this.searchTerm, this.localActive, this.cnfActive);

  @override List<Object> get props => [searchTerm];
}
