part of 'filter_bloc.dart';

abstract class FilterState {
  final FilterDataSchema? defaultFilterData;
  final FilterApplySchema selectedFilterData;
  final List<ProductDiamondSchema> diamonds;

  FilterState({
    required this.defaultFilterData,
    required this.selectedFilterData,
    required this.diamonds,
  });
}

class InitialFilterState extends FilterState {
  InitialFilterState()
      : super(
          defaultFilterData: null,
          selectedFilterData: FilterApplySchema.newEmpty(),
          diamonds: [],
        );
}

class FilterDefaultDataLoadedState extends FilterState {
  FilterDefaultDataLoadedState({
    required super.defaultFilterData,
    required super.selectedFilterData,
  }) : super(diamonds: []);
}

class FilterApplySuccess extends FilterState {
  FilterApplySuccess({
    required super.defaultFilterData,
    required super.selectedFilterData,
    required super.diamonds,
  });
}
