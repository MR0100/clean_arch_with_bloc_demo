import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/cart/domain/usecases/fetch_initial_cart_data_usecase.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<FetchInitialCartDataEvent>(_onInit);
  }

  Future<void> _onInit(
      FetchInitialCartDataEvent event, Emitter<CartState> emit) async {
    List<ProductDiamondSchema> cartItems =
        await di.get<FetchInitialCartDataUseCase>()(param: null);

    cartItems.sort((a, b) => a.lotId.compareTo(b.lotId));
    int count = 0;
    double totalPrice = 0;
    double totalCarat = 0;
    double avgPrice = 0;
    double avgDiscount = 0;
    double totalDiscount = 0;
    for (ProductDiamondSchema e in cartItems) {
      count += e.cartCount;
      totalPrice = totalPrice + (e.perCaratRate * e.cartCount);
      totalCarat = totalCarat + (e.carat * e.cartCount);
      totalDiscount = totalDiscount + (e.discount * e.cartCount);
    }

    avgPrice = totalPrice / count;
    avgDiscount = totalDiscount / count;

    double discountPrice = totalPrice * avgDiscount.abs() / 100; 

    double netAmount = totalPrice - discountPrice;

    emit(
      CartDataLoadedState(
        cartItems: cartItems,
        count: count,
        totalCarat: totalCarat,
        totalPrice: totalPrice,
        avgPrice: avgPrice,
        avgDiscount: avgDiscount,
        netAmount: netAmount,
      ),
    );
  }
}
