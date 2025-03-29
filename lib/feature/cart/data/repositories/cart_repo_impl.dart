import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/feature/cart/data/sources/local/cart_api.dart';
import 'package:kgk/feature/cart/domain/repositories/cart_repo.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

class CartRepoImpl extends CartRepo {
  final CartAPI cartApi;

  CartRepoImpl({required this.cartApi});
  @override
  Future<List<ProductDiamondSchema>> fetchInitialCartData() async {
    List<Json> itemJson = await cartApi.getInitialCartData();

    if (itemJson.isNotEmpty) {
      return itemJson.map((e) => ProductDiamondSchema.fromJson(e)).toList();
    }

    return [];
  }
}
