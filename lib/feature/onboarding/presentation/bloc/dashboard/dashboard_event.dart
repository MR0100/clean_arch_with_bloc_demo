part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class OnChangePage extends DashboardEvent {
  final int currentPageIndex;

  OnChangePage({required this.currentPageIndex});
}
