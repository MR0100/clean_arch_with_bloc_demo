part of 'dashboard_bloc.dart';

abstract class DashboardState {
  final int currentPageIndex;

  DashboardState({required this.currentPageIndex});

  bool isSelected(int value) => value == currentPageIndex;
}

class DashboardInitState extends DashboardState {
  DashboardInitState({required super.currentPageIndex});
}

class UpdatedState extends DashboardState {
  UpdatedState({required super.currentPageIndex});
}
