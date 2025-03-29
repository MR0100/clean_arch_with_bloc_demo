import 'package:kgk/core/utils/constants/app_data.dart';
import 'package:kgk/core/utils/constants/app_shared_pref_key.dart';
import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/feature/cart/data/sources/local/cart_api.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/main.dart';

class CartApiImpl extends CartAPI {
  @override
  Future<List<Json>> getInitialCartData() async {
    List<String> cartItemKeys =
        preferences.getStringList(AppSharedPrefKey.listOfCartItems) ?? [];

    List<Json> itemJson = AppData.productData
        .where((e) => cartItemKeys
            .any((i) => ProductDiamondSchema.fromJson(e).lotId == i))
        .toList();

    return itemJson;
  }
}
