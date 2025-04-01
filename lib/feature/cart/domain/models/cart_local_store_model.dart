import 'dart:convert';

import 'package:kgk/core/utils/constants/app_types.dart';

class CartLocalStoreModel {
  final String productId;
  final int cartCount;

  CartLocalStoreModel({
    required this.productId,
    required this.cartCount,
  });

  factory CartLocalStoreModel.fromJsonString(String data) {
    Json json = jsonDecode(data);
    return CartLocalStoreModel(
      productId: json['product_id'],
      cartCount: json['cart_count'],
    );
  }

  toJson() => {
        "product_id": productId,
        "cart_count": cartCount,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
