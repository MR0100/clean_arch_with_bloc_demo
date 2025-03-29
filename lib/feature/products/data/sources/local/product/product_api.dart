import 'package:kgk/core/utils/constants/app_types.dart';

abstract class ProductAPI {
  Future<List<Json>> fetchAllProducts();
}
