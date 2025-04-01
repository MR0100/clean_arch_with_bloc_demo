import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';
import 'package:kgk/feature/products/presentation/widgets/diamond_card_component.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    di.get<CartBloc>().add(FetchInitialCartDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          String text = "Cart";
          if (state is CartDataLoadedState) {
            text = "$text (${state.count})";
          }

          return Text(text);
        }),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is! CartDataLoadedState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.kPrimary),
              ),
            );
          }

          if (state.cartItems.isEmpty) {
            return Center(
              child: Text(
                "Cart is Empty!\nAdd your first product!",
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              ProductDiamondSchema diamond = state.cartItems[index];
              return DiamondCardComponent(
                diamond: diamond,
                addToCart: () {
                  di.get<ProductBloc>().add(OnCartCountUpdate(
                      product: diamond, type: OnCartCountUpdateType.inc));
                },
                incCart: () {
                  di.get<ProductBloc>().add(OnCartCountUpdate(
                      product: diamond, type: OnCartCountUpdateType.inc));
                },
                decCart: () {
                  di.get<ProductBloc>().add(OnCartCountUpdate(
                      product: diamond, type: OnCartCountUpdateType.dec));
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
          );
        },
      ),
    );
  }
}
