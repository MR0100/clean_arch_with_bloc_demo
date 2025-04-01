import 'package:flutter/material.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/shared/presentation/widgets/buttons/app_button.dart';

class DiamondCardComponent extends StatelessWidget {
  final ProductDiamondSchema diamond;
  final VoidCallback addToCart;
  final VoidCallback incCart;
  final VoidCallback decCart;
  const DiamondCardComponent({
    required this.diamond,
    required this.addToCart,
    required this.incCart,
    required this.decCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isExpanded = ValueNotifier(false);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.kBlack.withAlpha(
            Color.getAlphaFromOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                diamond.lotId,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.kTextSubTitle,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.kBlack.withAlpha(
                              Color.getAlphaFromOpacity(0.1),
                            ),
                          ),
                          gradient: AppColors.diamondCardInnerGradient,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${diamond.perCaratRate} Rap",
                                  style: TextStyle(
                                    color: AppColors.kTextBlack,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "\$-/Cts",
                                    style: TextStyle(
                                      color: AppColors.kTextBlack,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$${diamond.finalAmount}",
                                  style: TextStyle(
                                    color: AppColors.kTextBlack,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            isExpanded.value = !isExpanded.value;
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.kBlue.withAlpha(
                                  Color.getAlphaFromOpacity(0.5),
                                ),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: -8,
                                  color: AppColors.kBlue,
                                ),
                              ],
                            ),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: isExpanded,
                              builder: (context, expanded, child) {
                                return Transform.rotate(
                                  angle: expanded || diamond.cartCount > 0 ? 3.14 / 2 : 0,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.kBlue,
                                    size: 20,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "more",
                          style: TextStyle(
                            color: AppColors.kBlue,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (diamond.cartCount > 0) ...{
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.kWhite,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.kWarning
                                .withAlpha(Color.getAlphaFromOpacity(0.2)),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.kWarning
                                  .withAlpha(Color.getAlphaFromOpacity(0.5)),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.card_travel,
                                color: AppColors.kWarning,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${diamond.cartCount}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kWarning,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                    },
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.kGreen,
                        border: Border.all(
                          color: AppColors.kGreen,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "${diamond.discount}%",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 16,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  diamond.shape,
                  diamond.color,
                  diamond.clarity,
                  diamond.cut,
                  diamond.polish,
                  diamond.symmetry,
                  diamond.lab,
                  "${diamond.carat} Carat",
                ]
                    .map(
                      (info) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          info,
                          style: TextStyle(
                            color: AppColors.kTextBlack,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: isExpanded,
              builder: (context, expanded, child) {
                if (expanded || diamond.cartCount > 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: AppColors.kPrimary
                            .withAlpha(Color.getAlphaFromOpacity(0.1)),
                        height: 16,
                      ),
                      SizedBox(
                        height: 40,
                        child: _body(),
                      )
                    ],
                  );
                }
                return SizedBox();
              },),
        ],
      ),
    );
  }

  Widget _body() {
    if (diamond.cartCount == 0) {
      return AppButton(
        label: "Add To Cart",
        onTap: addToCart,
      );
    }

    if (diamond.cartCount > 0) {
      return Row(
        children: [
          Expanded(
            child: Text(
              "Update Cart",
              style: TextStyle(
                color: AppColors.kPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 45,
            child: AppButton(
              isOutlined: true,
              label: "-1",
              onTap: decCart,
            ),
          ),
          SizedBox(width: 16),
          Text(
            "${diamond.cartCount}",
            style: TextStyle(
              color: AppColors.kPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            width: 45,
            child: AppButton(
              isOutlined: true,
              label: "+1",
              onTap: incCart,
            ),
          ),
        ],
      );
    }

    return SizedBox();
  }
}
