part of 'product_bloc.dart';

abstract class ProductState {
  final List<ProductDiamondSchema> diamonds;

  ProductState({required this.diamonds});
}

class ProductInitState extends ProductState {
  ProductInitState() : super(diamonds: []);
}

class ProductDataLoading extends ProductState {
  ProductDataLoading() : super(diamonds: []);
}

class ProductDataSuccess extends ProductState {
  ProductDataSuccess({required super.diamonds});
}
