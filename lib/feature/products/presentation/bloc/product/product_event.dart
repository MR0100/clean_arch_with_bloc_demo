part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchAllProductsPrdEvent extends ProductEvent {}

enum OnCartCountUpdateType {
  inc,
  dec,
}

class OnCartCountUpdate extends ProductEvent {
  final ProductDiamondSchema product;
  final OnCartCountUpdateType type;

  OnCartCountUpdate({required this.product, required this.type});
}
