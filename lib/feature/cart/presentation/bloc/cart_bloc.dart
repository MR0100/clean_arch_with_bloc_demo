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

    emit(CartDataLoadedState(cartItems: cartItems));
  }
}
