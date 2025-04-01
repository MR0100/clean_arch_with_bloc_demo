part of 'filter_bloc.dart';

abstract class FilterEvent {}

class OnFetchFilterDataEvent extends FilterEvent {}

class OnApplyFilterEvent extends FilterEvent {}

class UpdateFilterDataEvent extends FilterEvent {
  final FilterApplySchema filter;

  UpdateFilterDataEvent({required this.filter});
}


class OnSortByPrice extends FilterEvent{ 
  final bool isAsc;

  OnSortByPrice({required this.isAsc}); 
}

class OnSortByCaratWeight extends FilterEvent{ 
  final bool isAsc;

  OnSortByCaratWeight({required this.isAsc});
  
}