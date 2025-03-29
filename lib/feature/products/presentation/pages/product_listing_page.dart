import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';
import 'package:kgk/feature/products/presentation/pages/product_filter_page.dart';
import 'package:kgk/feature/products/presentation/widgets/diamond_card_component.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  @override
  void initState() {
    super.initState();
    di.get<ProductBloc>().add(FetchAllProductsPrdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diamond List"),
        actions: [
          IconButton(
            onPressed: () {
              ProductFilterPage.openAsBottomSheet(
                context,
                args: ProductFilterArg(
                  diamonds: di.get<ProductBloc>().state.diamonds,
                ),
              );
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: AppColors.kBlack,
              size: 25,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is ProductDataLoading || state is ProductInitState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.kPrimary),
              ),
            );
          }

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: state.diamonds.length,
            itemBuilder: (context, index) {
              ProductDiamondSchema diamond = state.diamonds[index];
              return DiamondCardComponent(
                diamond: diamond,
                onExpand: () {
                  di
                      .get<ProductBloc>()
                      .add(ToggleProductCardEventPrdEvent(index: index));
                },
                addToCart: () {
                  di
                      .get<ProductBloc>()
                      .add(OnAddToCartProductEvent(index: index));
                },
                incCart: () {
                  di.get<ProductBloc>().add(OnCartCountUpdate(
                      index: index, type: OnCartCountUpdateType.inc));
                },
                decCart: () {
                  di.get<ProductBloc>().add(OnCartCountUpdate(
                      index: index, type: OnCartCountUpdateType.dec));
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
