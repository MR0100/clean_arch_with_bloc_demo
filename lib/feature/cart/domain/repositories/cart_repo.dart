import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

abstract class CartRepo {
  Future<List<ProductDiamondSchema>> fetchInitialCartData();
}
