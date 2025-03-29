import 'package:kgk/core/utils/usecases/usecase.dart';
import 'package:kgk/feature/cart/domain/repositories/cart_repo.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

class FetchInitialCartDataUseCase
    extends UseCase<List<ProductDiamondSchema>, void> {
  final CartRepo cartRepo;
  FetchInitialCartDataUseCase({required this.cartRepo});

  @override
  Future<List<ProductDiamondSchema>> call({required void param}) async {
    return cartRepo.fetchInitialCartData();
  }
}
