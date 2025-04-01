import 'package:kgk/feature/cart/domain/models/cart_local_store_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;

class AppSharedPrefKey {
  static const listOfCartItems = "KGK_LIST_OF_CART_ITEMS";

  // get products from the local cart list.
  static List<CartLocalStoreModel> getFromCartList() {
    List<String> cartItems = pref.getStringList(listOfCartItems) ?? [];
    return cartItems.map((e) => CartLocalStoreModel.fromJsonString(e)).toList();
  }

  // add products to the local cart list.
  static Future<void> addIdToCartList(CartLocalStoreModel product) async {
    List<String> cartItems = pref.getStringList(listOfCartItems) ?? [];
    cartItems.add(product.toString());
    await pref.setStringList(listOfCartItems, cartItems);
  }

  // remove from the local cart list.
  static Future<void> removeIdFromCartList(String productId) async {
    List<String> cartItems = pref.getStringList(listOfCartItems) ?? [];
    List<CartLocalStoreModel> cartItemsModel = cartItems
        .map(
          (e) => CartLocalStoreModel.fromJsonString(e),
        )
        .toList();
    cartItemsModel.removeWhere((e) => e.productId == productId);
    cartItems = cartItemsModel.map((e) => e.toString()).toList();
    await pref.setStringList(listOfCartItems, cartItems);
  }

  // check if the data is in the cart list or not.
  // if the item is in the cart then get the count of item.
  // otherwise, return 0 to indicate no items in cart.
  static Future<int> ifInCartGetCount(String productId) async {
    List<CartLocalStoreModel> cartItems = getFromCartList();
    List<CartLocalStoreModel> match =
        cartItems.where((e) => e.productId == productId).toList();

    if (match.isNotEmpty) {
      return match.first.cartCount;
    } else {
      return 0;
    }
  }
}
