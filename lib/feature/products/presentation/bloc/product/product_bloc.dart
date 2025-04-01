import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/helper/pref_helpers/cart_pref_helper.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/usecases/product/load_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitState()) {
    on<FetchAllProductsPrdEvent>(_loadProducts);
    on<OnCartCountUpdate>(_updateCartCount);
  }

  Future<void> _updateCartCount(
      OnCartCountUpdate event, Emitter<ProductState> emit) async {
    List<ProductDiamondSchema> data = state.diamonds;

    int index = data.indexWhere((e) => e.lotId == event.product.lotId);

    if(event.type == OnCartCountUpdateType.inc) { 
      data[index] = await CartPrefHelper.incCartProduct(data[index]);
    }else {
      data[index] = await CartPrefHelper.decCount(data[index]);
    }

    di.get<CartBloc>().add(FetchInitialCartDataEvent());

    emit(ProductDataSuccess(diamonds: data));
  }

  Future<void> _loadProducts(
      FetchAllProductsPrdEvent event, Emitter<ProductState> emit) async {
    // loading state.
    emit(ProductDataLoading());

    // fetching data..
    List<ProductDiamondSchema> productData =
        await di.get<LoadProductUseCase>()(param: null);

    // loading success state with data.
    emit(ProductDataSuccess(diamonds: productData));
  }
}
