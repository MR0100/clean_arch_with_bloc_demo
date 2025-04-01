import 'dart:convert';

import 'package:kgk/core/utils/constants/app_shared_pref_key.dart';

import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';

class CartPrefHelper{

  // get products from the local cart list.
  static List<ProductDiamondSchema> getFromCartList() {
    List<String> cartItems = pref.getStringList(AppSharedPrefKey.listOfCartItems) ?? [];
    return cartItems.map((e) => ProductDiamondSchema.fromJson(jsonDecode(e))).toList();
  }

  // add products to the local cart list.
  static Future<ProductDiamondSchema> incCartProduct(ProductDiamondSchema product) async {
    List<String> cartItems = pref.getStringList(AppSharedPrefKey.listOfCartItems) ?? [];

    List<ProductDiamondSchema> items = cartItems.map((i)=>ProductDiamondSchema.fromJson(jsonDecode(i))).toList();

    late ProductDiamondSchema item; 


    // check if the list is not empty then find the index of matching product Id to increment the cart count. 
    if(items.isNotEmpty) { 
      int index = items.indexWhere((i)=>i.lotId == product.lotId);
      
      if(index == -1 ){
        // -1 means there is no data matching the condition. 
        // so, create new record. 
         item = product.copyWith(cartCount: 1);
         cartItems.add(item.toString());
      }else{
        // found product!
        // increment the cart count by 1.
        item = items[index].copyWith(cartCount: product.cartCount + 1);
        cartItems.removeAt(index); 
        cartItems.add(item.toString());
      }
    }else{
      // list is empty. 
      // create the first cart record. 
      item = product.copyWith(cartCount: 1);
      cartItems.add(item.toString());
    }


    // preserve list in the local storage using shared preferences. 
    await pref.setStringList(AppSharedPrefKey.listOfCartItems, cartItems);

    return item;
  }

  // remove from the local cart list.
  static Future<ProductDiamondSchema> decCount(ProductDiamondSchema product) async {
    List<String> cartItems = pref.getStringList(AppSharedPrefKey.listOfCartItems) ?? [];
     List<ProductDiamondSchema> items = cartItems.map((i)=>ProductDiamondSchema.fromJson(jsonDecode(i))).toList();



    ProductDiamondSchema? item;
     if(items.isNotEmpty){
      int index = items.indexWhere((i)=>i.lotId == product.lotId);

      if(index != -1){
        item = items[index];
        // check if the current cart count is 1 then remove from list. 
        // because, decreasing from 1 to 0 mean removing the item from cart. 
        if(item.cartCount == 1){
          item = item.copyWith(cartCount: 0);
          items.removeAt(index);
        }else{  
          // create new item with decreased count. 
          item = item.copyWith(cartCount: item.cartCount - 1);
          // remove the current item from list with old value. 
          items.removeAt(index);
          // insert new item with updated value. 
          items.add(item);
        }
      }
     }

    cartItems = items.map((e)=>e.toString()).toList();

    await pref.setStringList(AppSharedPrefKey.listOfCartItems, cartItems);

    return item ?? product.copyWith(cartCount: 0);
  }

  // check if the data is in the cart list or not.
  // if the item is in the cart then get the count of item.
  // otherwise, return 0 to indicate no items in cart.
  // static Future<int> ifInCartGetCount(String productId) async {
  //   List<CartLocalStoreModel> cartItems = getFromCartList();
  //   List<CartLocalStoreModel> match =
  //       cartItems.where((e) => e.productId == productId).toList();
  //   if (match.isNotEmpty) {
  //     return match.first.cartCount;
  //   } else {
  //     return 0;
  //   }
  // }
}