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

  ValueNotifier<bool> viewSummary = ValueNotifier(false);

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

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView.separated(
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
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewSummary.value = !viewSummary.value;
                },
                child: ValueListenableBuilder<bool>(
                    valueListenable: viewSummary,
                    builder: (context, value, child) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              spreadRadius: -15,
                              color: AppColors.kPrimary,
                            )
                          ],
                          border: Border(
                              top: BorderSide(
                            color: AppColors.kPrimary
                                .withAlpha(Color.getAlphaFromOpacity(0.2)),
                          )),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          gradient: AppColors.diamondCardInnerGradient,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Show Summary",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: value ? (3.14 / 2) * 3 : 3.14 / 2,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            if (value) ...{
                              Divider(
                                color: AppColors.kPrimary
                                    .withAlpha(Color.getAlphaFromOpacity(0.1)),
                                height: 16,
                              ),
                              _getDataListTile(
                                  label: "Total Carat",
                                  value: "${state.totalCarat} Carats"),
                              _getDataListTile(
                                  label: "Total Price",
                                  value:
                                      "\$ ${state.totalPrice.toStringAsFixed(2)}"),
                              _getDataListTile(
                                  label: "Avg. Price",
                                  value:
                                      "\$ ${state.avgPrice.toStringAsFixed(2)}"),
                              _getDataListTile(
                                  label: "Avg. Disc. (%)",
                                  value:
                                      "${state.avgDiscount.toStringAsFixed(2)} %"),
                              _getDataListTile(label: "-", value: "-"),
                              _getDataListTile(
                                  label: "Net Amount",
                                  value:
                                      "${state.netAmount.toStringAsFixed(2)} %"),
                            },
                          ],
                        ),
                      );
                    }),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _getDataListTile({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
