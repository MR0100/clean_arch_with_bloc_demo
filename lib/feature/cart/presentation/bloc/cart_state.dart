part of 'cart_bloc.dart';

abstract class CartState {
  final List<ProductDiamondSchema> cartItems;

  CartState({required this.cartItems});
}

class InitialCartState extends CartState {
  InitialCartState() : super(cartItems: []);
}

class CartDataLoadedState extends CartState {
  final int count; 
  CartDataLoadedState({required this.count, required super.cartItems});
}
