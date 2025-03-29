import 'package:kgk/core/utils/constants/app_types.dart';

abstract class CartAPI {
  Future<List<Json>> getInitialCartData();
}
