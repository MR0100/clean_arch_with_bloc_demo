import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitState(currentPageIndex: 0)) {
    on<OnChangePage>(_onChangePage);
  }

  void _onChangePage(OnChangePage event, Emitter<DashboardState> emit) {
    emit(UpdatedState(currentPageIndex: event.currentPageIndex));
  }
}
