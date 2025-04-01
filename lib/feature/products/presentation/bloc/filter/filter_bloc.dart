import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/models/product/filter/filter_apply_schema.dart';
import 'package:kgk/feature/products/domain/models/product/filter/filter_data_schema.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final ProductBloc productBloc;
  FilterBloc({required this.productBloc}) : super(InitialFilterState()) {
    on<OnFetchFilterDataEvent>(_onFetchFilterData);
    on<UpdateFilterDataEvent>(_onUpdateFilterData);
    on<OnApplyFilterEvent>(_onApplyFilter);
    on<OnSortByPrice>(_onSortByPrice);
    on<OnSortByCaratWeight>(_onSortByCarat);
  }

  void _onSortByCarat(OnSortByCaratWeight event, Emitter<FilterState> emit) {
    List<ProductDiamondSchema> items = state.diamonds;

    if (event.isAsc) {
      items.sort((a, b) => a.carat.compareTo(b.carat));
    } else {
      items.sort((a, b) => b.carat.compareTo(a.carat));
    }

    emit(
      FilterApplySuccess(
        defaultFilterData: state.defaultFilterData,
        selectedFilterData: state.selectedFilterData,
        diamonds: items,
      ),
    );
  }

  void _onSortByPrice(OnSortByPrice event, Emitter<FilterState> emit) {
    List<ProductDiamondSchema> items = state.diamonds;

    if (event.isAsc) {
      items.sort((a, b) => a.perCaratRate.compareTo(b.perCaratRate));
    } else {
      items.sort((a, b) => b.perCaratRate.compareTo(a.perCaratRate));
    }

    emit(
      FilterApplySuccess(
        defaultFilterData: state.defaultFilterData,
        selectedFilterData: state.selectedFilterData,
        diamonds: items,
      ),
    );
  }

  void _onApplyFilter(OnApplyFilterEvent event, Emitter<FilterState> emit) {
    FilterApplySchema filters = state.selectedFilterData;
    List<ProductDiamondSchema> filteredData = [];

    String from = filters.caratFrom.isEmpty ? "0.0" : filters.caratFrom;
    String to = filters.caratTo.isEmpty ? "0.0" : filters.caratTo;

    for (var e in productBloc.state.diamonds) {
      if (filters.shape.contains(e.shape) ||
          filters.lab.contains(e.lab) ||
          filters.color.contains(e.color) ||
          filters.clarity.contains(e.clarity)) {
        filteredData.add(e);
        continue;
      }

      // if the from value is empty but the to value is not empty.
      // show all the data that is smaller in compare.
      if (from == "0.0" && to != "0.0") {
        if (e.carat <= double.parse(to)) {
          filteredData.add(e);
          continue;
        }
      }

      // if the from value is not empty but the to value is empty.
      // show all the data that is bigger in compare.
      if (from != "0.0" && to == "0.0") {
        if (e.carat >= double.parse(from)) {
          filteredData.add(e);
          continue;
        }
      }

      // if both values are provided then show the data that is between both values.
      if (double.parse(from) <= e.carat && e.carat <= double.parse(to)) {
        filteredData.add(e);
        continue;
      }
    }

    // update state with the filtered diamond data.
    emit(
      FilterApplySuccess(
        defaultFilterData: state.defaultFilterData,
        selectedFilterData: state.selectedFilterData,
        diamonds: filteredData,
      ),
    );
  }

  void _onUpdateFilterData(
      UpdateFilterDataEvent event, Emitter<FilterState> emit) {
    emit(
      FilterDefaultDataLoadedState(
        defaultFilterData: state.defaultFilterData,
        selectedFilterData: event.filter,
      ),
    );
  }

  void _onFetchFilterData(
      OnFetchFilterDataEvent event, Emitter<FilterState> emit) {
    FilterDataSchema filterData = FilterDataSchema(
      labs: <String>{},
      shapes: <String>{},
      colors: <String>{},
      clarity: <String>{},
    );

    for (var e in productBloc.state.diamonds) {
      if (e.carat < filterData.caratFromMin) {
        filterData.caratFromMin = e.carat;
      }

      if (e.carat > filterData.caratToMax) {
        filterData.caratToMax = e.carat;
      }

      filterData.labs.add(e.lab);
      filterData.shapes.add(e.shape);
      filterData.colors.add(e.color);
      filterData.clarity.add(e.clarity);
    }

    emit(FilterDefaultDataLoadedState(
        defaultFilterData: filterData,
        selectedFilterData: state.selectedFilterData));
  }
}
