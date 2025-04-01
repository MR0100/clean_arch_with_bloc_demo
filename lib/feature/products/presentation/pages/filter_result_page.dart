import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/presentation/bloc/filter/filter_bloc.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';
import 'package:kgk/feature/products/presentation/pages/product_filter_page.dart';
import 'package:kgk/feature/products/presentation/widgets/diamond_card_component.dart';

class FilterResultPage extends StatelessWidget {
  const FilterResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state is! FilterApplySuccess) {
              return Text("Filter Result");
            }
            return Text("Filter Results (${state.diamonds.length})");
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              ProductFilterPage.openAsBottomSheet(
                context,
                args: ProductFilterArg(
                  diamonds: di.get<ProductBloc>().state.diamonds,
                  isFromResultScreen: true,
                ),
              );
            },
            icon: Icon(
              Icons.filter_alt_outlined,
              color: AppColors.kBlack,
              size: 25,
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: AppColors.kPrimary.withAlpha(Color.getAlphaFromOpacity(0.1)),
            indent: 10,
            endIndent: 10,
          ),
          PopupMenuButton<String> (
            onSelected: (String selected){
              if(selected == 'final_price_asc') {
                di.get<FilterBloc>().add(OnSortByPrice(isAsc: true));
              }
              else if(selected == 'final_price_desc') {
                di.get<FilterBloc>().add(OnSortByPrice(isAsc: false));
              }
              else if(selected == 'carat_weight_asc') {
                di.get<FilterBloc>().add(OnSortByCaratWeight(isAsc: true));
              }
              else if(selected == 'carat_weight_desc') {
                di.get<FilterBloc>().add(OnSortByCaratWeight(isAsc: false));
              }
            },
            itemBuilder: (context) => [
              {
                "title": "Final Price (Asc)", 
                "value": "final_price_asc",
              },{
                "title": "Final Price (Desc)", 
                "value": "final_price_desc",
              },{
                "title": "Carat Weight (Asc)", 
                "value": "carat_weight_asc",
              },{
                "title": "Carat Weight (Dsc)", 
                "value": "carat_weight_desc",
              }
            ].map((Map<String, dynamic> e) => PopupMenuItem<String>(
                value: e['value'],
                child: Text(
                  "${e['title']}",
                ),
              ),).toList(),
            child: Row(
              children: [
                Text('Sort By'),
                SizedBox(width: 4),
                Icon(
                  Icons.filter_list_outlined,
                  size: 18,
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: AppColors.kPrimary.withAlpha(Color.getAlphaFromOpacity(0.1)),
            indent: 10,
            endIndent: 10,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child:
              BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
            if (state is! FilterApplySuccess) {
              return SizedBox.shrink();
            }

            return Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.kPrimary
                        .withAlpha(Color.getAlphaFromOpacity(0.05)),
                    width: 2,
                  ),
                ),
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: state.selectedFilterData.appliedFiltersList.length,
                itemBuilder: (context, index) {
                  String item =
                      state.selectedFilterData.appliedFiltersList[index];
                  return Center(
                    child: Container(
                      height: 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: AppColors.diamondCardInnerGradient,
                        border: Border.all(
                          color: AppColors.kPrimary.withAlpha(
                            Color.getAlphaFromOpacity(0.2),
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: AppColors.kTextBlack,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8),
              ),
            );
          }),
        ),
      ),
      body: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          if (state is! FilterApplySuccess) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.kPrimary),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: state.diamonds.length,
                  itemBuilder: (context, index) {
                    ProductDiamondSchema diamond = state.diamonds[index];
                    return DiamondCardComponent(
                      diamond: diamond,
                      addToCart: () {},
                      incCart: () {},
                      decCart: () {},
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
