import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

abstract class ProductRepo {
  Future<List<ProductDiamondSchema>> fetchProducts();
}
