import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/usecases/product/load_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitState()) {
    on<FetchAllProductsPrdEvent>(_loadProducts);
    on<ToggleProductCardEventPrdEvent>(_toggleProductCardExpansion);
    on<OnAddToCartProductEvent>(_onAddToCart);
    on<OnCartCountUpdate>(_updateCartCount);
  }

  Future<void> _updateCartCount(
      OnCartCountUpdate event, Emitter<ProductState> emit) async {
    List<ProductDiamondSchema> data = state.diamonds;
    data[event.index] = data[event.index].copyWith(
      cartCount: data[event.index].cartCount +
          (event.type == OnCartCountUpdateType.inc ? 1 : -1),
    );

    emit(ProductDataSuccess(diamonds: data));
  }

  Future<void> _onAddToCart(
      OnAddToCartProductEvent event, Emitter<ProductState> emit) async {
    List<ProductDiamondSchema> data = state.diamonds;
    data[event.index] = data[event.index].copyWith(
      cartCount: data[event.index].cartCount + 1,
    );

    emit(ProductDataSuccess(diamonds: data));
  }

  Future<void> _toggleProductCardExpansion(
      ToggleProductCardEventPrdEvent event, Emitter<ProductState> emit) async {
    // copy data in local state.
    List<ProductDiamondSchema> data = state.diamonds;

    // update the values inside isExpanded and update local state.
    data[event.index] =
        data[event.index].copyWith(isExpanded: !data[event.index].isExpanded);

    // update global state according to local state.
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
