import 'package:kgk/core/helper/pref_helpers/cart_pref_helper.dart';
import 'package:kgk/feature/cart/domain/repositories/cart_repo.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

class CartRepoImpl extends CartRepo {
  @override
  Future<List<ProductDiamondSchema>> fetchInitialCartData() async {
    // fetch cart data. 
    List<ProductDiamondSchema> cart = CartPrefHelper.getFromCartList();


    return cart;
  }
}
