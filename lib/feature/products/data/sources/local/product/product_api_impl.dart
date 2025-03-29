import 'package:kgk/core/utils/constants/app_data.dart';
import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/feature/products/data/sources/local/product/product_api.dart';

class ProductApiImpl extends ProductAPI {
  @override
  Future<List<Json>> fetchAllProducts() async {
    return AppData.productData;
  }
}
