part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchAllProductsPrdEvent extends ProductEvent {}

class ToggleProductCardEventPrdEvent extends ProductEvent {
  final int index;

  ToggleProductCardEventPrdEvent({required this.index});
}

class OnAddToCartProductEvent extends ProductEvent {
  final int index;

  OnAddToCartProductEvent({required this.index});
}

enum OnCartCountUpdateType {
  inc,
  dec,
}

class OnCartCountUpdate extends ProductEvent {
  final int index;
  final OnCartCountUpdateType type;

  OnCartCountUpdate({required this.index, required this.type});
}
