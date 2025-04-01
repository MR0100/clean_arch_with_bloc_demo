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
  final double totalPrice;
  final double avgPrice;
  final double totalCarat;
  final double avgDiscount;
  final double netAmount;
  CartDataLoadedState({
    required this.totalPrice,
    required this.avgDiscount,
    required this.avgPrice,
    required this.totalCarat,
    required this.count,
    required this.netAmount,
    required super.cartItems,
  });
}
