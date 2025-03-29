import 'package:kgk/core/utils/usecases/usecase.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/repositories/product_repo.dart';

class LoadProductUseCase extends UseCase<List<ProductDiamondSchema>, void> {
  final ProductRepo productRepo;

  LoadProductUseCase({required this.productRepo});

  @override
  Future<List<ProductDiamondSchema>> call({required param}) async {
    return productRepo.fetchProducts();
  }
}
