import 'package:kgk/core/utils/constants/app_data.dart';
import 'package:kgk/core/utils/constants/app_shared_pref_key.dart';
import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/feature/cart/data/sources/local/cart_api.dart';
import 'package:kgk/feature/cart/domain/models/cart_local_store_model.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

class CartApiImpl extends CartAPI {
  @override
  Future<List<Json>> getInitialCartData() async {
    List<CartLocalStoreModel> cartItemKeys = AppSharedPrefKey.getFromCartList();

    List<Json> itemJson = AppData.productData
        .where((e) => cartItemKeys
            .any((i) => ProductDiamondSchema.fromJson(e).lotId == i.productId))
        .toList();

    return itemJson;
  }
}
