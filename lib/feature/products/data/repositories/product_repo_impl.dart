import 'package:kgk/core/helper/pref_helpers/cart_pref_helper.dart';
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

    List<ProductDiamondSchema> diamonds = productJson.map((e) => ProductDiamondSchema.fromJson(e)).toList();
    List<ProductDiamondSchema> cart = CartPrefHelper.getFromCartList();


    if(cart.isNotEmpty){

      return diamonds.map((e) {
        int index = cart.indexWhere((c) => c.lotId == e.lotId);

        if(index != -1){
          e = e.copyWith(
            cartCount: cart[index].cartCount,
          );
        }

        return e;
      }).toList();
    }

    return diamonds;
  }
}
