import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/cart/presentation/pages/cart_page.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:kgk/feature/products/presentation/pages/product_listing_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const List<Widget> pages = [
    ProductListingPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
        return pages[state.currentPageIndex];
      }),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: -20,
              color: AppColors.kPrimary,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            {
              "name": "Products",
              "index": 0,
              "icon": Icons.list,
            },
            {
              "name": "Cart",
              "index": 1,
              "icon": Icons.card_travel,
            }
          ].map((Map<String, dynamic> e) {
            String name = e["name"];
            int index = e["index"];
            IconData icon = e["icon"];

            return Expanded(
              child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    di
                        .get<DashboardBloc>()
                        .add(OnChangePage(currentPageIndex: index));
                  },
                  child: Container(
                    color: AppColors.kWhite,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 20,
                          color: state.isSelected(index)
                              ? AppColors.kPrimary
                              : AppColors.kTextBlack,
                        ),
                        SizedBox(width: 10),
                        Text(
                          name,
                          style: TextStyle(
                            color: state.isSelected(index)
                                ? AppColors.kPrimary
                                : AppColors.kTextBlack,
                            fontWeight: state.isSelected(index)
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }).toList(),
        ),
      ),
    );
  }
}
