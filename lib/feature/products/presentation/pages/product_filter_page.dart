import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/router/app_router.dart';
import 'package:kgk/core/styles/app_colors.dart';
import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/products/domain/models/product/diamond/product_diamond_schema.dart';
import 'package:kgk/feature/products/domain/models/product/filter/filter_apply_schema.dart';
import 'package:kgk/feature/products/presentation/bloc/filter/filter_bloc.dart';
import 'package:kgk/shared/presentation/widgets/buttons/app_button.dart';
import 'package:kgk/shared/presentation/widgets/input/app_text_field.dart';

class ProductFilterArg {
  final List<ProductDiamondSchema> diamonds;
  final bool isFromResultScreen;

  ProductFilterArg({
    required this.diamonds,
    this.isFromResultScreen = false,
  });
}

class ProductFilterPage extends StatefulWidget {
  final ProductFilterArg args;
  const ProductFilterPage({required this.args, super.key});

  @override
  State<ProductFilterPage> createState() => _ProductFilterPageState();

  /// opens this product filter page in the modal bottom sheet.
  static void openAsBottomSheet(
    BuildContext context, {
    required ProductFilterArg args,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ProductFilterPage(
            args: args,
          ),
        );
      },
      scrollControlDisabledMaxHeightRatio: 0.9,
      backgroundColor: AppColors.kWhite,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      showDragHandle: false,
    );
  }
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  final TextEditingController caratFromTextController = TextEditingController();
  final TextEditingController caratToTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    di.get<FilterBloc>().add(OnFetchFilterDataEvent());
    di
        .get<FilterBloc>()
        .add(UpdateFilterDataEvent(filter: FilterApplySchema.newEmpty()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterState>(
      bloc: di.get<FilterBloc>(),
      listener: (context, state) {
        if (state is FilterApplySuccess) {
          // close the current model or screen.
          Navigator.pop(context);

          // open result page.
          if (!widget.args.isFromResultScreen) {
            Navigator.pushNamed(context, AppRouterPaths.filterResult.path);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Filter",
          ),
        ),
        body: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state is! FilterDefaultDataLoadedState) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.kPrimary),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: <Json>[
                      {
                        "title": "Carat From",
                        "controller": caratFromTextController,
                        "event": (String val) {
                          di.get<FilterBloc>().add(
                                UpdateFilterDataEvent(
                                  filter: state.selectedFilterData
                                      .copyWith(caratFrom: val),
                                ),
                              );
                        },
                      },
                      {},
                      {
                        "title": "Carat To",
                        "controller": caratToTextController,
                        "event": (String val) {
                          di.get<FilterBloc>().add(
                                UpdateFilterDataEvent(
                                  filter: state.selectedFilterData
                                      .copyWith(caratTo: val),
                                ),
                              );
                        }
                      }
                    ].map(
                      (Json e) {
                        if (e.isEmpty) {
                          return SizedBox(width: 16);
                        }

                        return AppTextField(
                          label: e["title"],
                          controller: e["controller"],
                          onChange: (p0) {
                            e["event"](p0);
                          },
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Labs"),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final String lab = state.defaultFilterData?.labs
                                    .elementAt(index) ??
                                '-';
                            return GestureDetector(
                              onTap: () {
                                di.get<FilterBloc>().add(
                                      UpdateFilterDataEvent(
                                        filter: state.selectedFilterData
                                            .copyWith(lab: {
                                          lab,
                                          ...state.selectedFilterData.lab
                                        }),
                                      ),
                                    );
                              },
                              child: Chip(
                                label: Text(
                                  lab,
                                  style: TextStyle(
                                    color: state.selectedFilterData.lab
                                            .contains(lab)
                                        ? AppColors.kWhite
                                        : AppColors.kTextBlack,
                                  ),
                                ),
                                backgroundColor:
                                    state.selectedFilterData.lab.contains(lab)
                                        ? AppColors.kPrimary
                                        : AppColors.kTransparent,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemCount: state.defaultFilterData?.labs.length ?? 0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Shapes"),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final String shape = state.defaultFilterData?.shapes
                                    .elementAt(index) ??
                                '-';
                            return GestureDetector(
                              onTap: () {
                                di.get<FilterBloc>().add(
                                      UpdateFilterDataEvent(
                                        filter: state.selectedFilterData
                                            .copyWith(shape: {
                                          shape,
                                          ...state.selectedFilterData.shape
                                        }),
                                      ),
                                    );
                              },
                              child: Chip(
                                label: Text(
                                  shape,
                                  style: TextStyle(
                                    color: state.selectedFilterData.shape
                                            .contains(shape)
                                        ? AppColors.kWhite
                                        : AppColors.kTextBlack,
                                  ),
                                ),
                                backgroundColor: state.selectedFilterData.shape
                                        .contains(shape)
                                    ? AppColors.kPrimary
                                    : AppColors.kTransparent,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemCount:
                              state.defaultFilterData?.shapes.length ?? 0,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Colors"),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final String color = state.defaultFilterData?.colors
                                    .elementAt(index) ??
                                '-';
                            return GestureDetector(
                              onTap: () {
                                di.get<FilterBloc>().add(
                                      UpdateFilterDataEvent(
                                        filter: state.selectedFilterData
                                            .copyWith(color: {
                                          color,
                                          ...state.selectedFilterData.color,
                                        }),
                                      ),
                                    );
                              },
                              child: Chip(
                                label: Text(
                                  color,
                                  style: TextStyle(
                                    color: state.selectedFilterData.color
                                            .contains(color)
                                        ? AppColors.kWhite
                                        : AppColors.kTextBlack,
                                  ),
                                ),
                                backgroundColor: state.selectedFilterData.color
                                        .contains(color)
                                    ? AppColors.kPrimary
                                    : AppColors.kTransparent,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemCount:
                              state.defaultFilterData?.colors.length ?? 0,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Clarity"),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final String clarity = state
                                    .defaultFilterData?.clarity
                                    .elementAt(index) ??
                                '-';
                            return GestureDetector(
                              onTap: () {
                                di.get<FilterBloc>().add(
                                      UpdateFilterDataEvent(
                                        filter: state.selectedFilterData
                                            .copyWith(clarity: {
                                          clarity,
                                          ...state.selectedFilterData.clarity,
                                        }),
                                      ),
                                    );
                              },
                              child: Chip(
                                label: Text(
                                  clarity,
                                  style: TextStyle(
                                    color: state.selectedFilterData.clarity
                                            .contains(clarity)
                                        ? AppColors.kWhite
                                        : AppColors.kTextBlack,
                                  ),
                                ),
                                backgroundColor: state
                                        .selectedFilterData.clarity
                                        .contains(clarity)
                                    ? AppColors.kPrimary
                                    : AppColors.kTransparent,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemCount:
                              state.defaultFilterData?.clarity.length ?? 0,
                        ),
                      ),
                    ],
                  ),

                  // Clarity
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppButton(
                      label: "Clear",
                      isOutlined: true,
                      onTap: () {
                        di.get<FilterBloc>().add(
                              UpdateFilterDataEvent(
                                filter: FilterApplySchema.newEmpty(),
                              ),
                            );
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                      flex: 2,
                      child: AppButton(
                        label: "Apply Filter",
                        onTap: state.selectedFilterData.canApplyFilter
                            ? () {
                                di.get<FilterBloc>().add(OnApplyFilterEvent());
                              }
                            : null,
                      ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
