part of 'filter_bloc.dart';

abstract class FilterEvent {}

class OnFetchFilterDataEvent extends FilterEvent {}

class OnApplyFilterEvent extends FilterEvent {}

class UpdateFilterDataEvent extends FilterEvent {
  final FilterApplySchema filter;

  UpdateFilterDataEvent({required this.filter});
}
