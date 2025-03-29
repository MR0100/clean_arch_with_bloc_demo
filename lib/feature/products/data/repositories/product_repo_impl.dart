import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/feature/products/data/sources/local/product/product_api.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/repositories/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductAPI productAPI;

  ProductRepoImpl({required this.productAPI});
  @override
  Future<List<ProductDiamondSchema>> fetchProducts() async {
    List<Json> productJson = await productAPI.fetchAllProducts();

    return productJson.map((e) => ProductDiamondSchema.fromJson(e)).toList();
  }
}
