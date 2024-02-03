import 'package:apple_shop/BLoC/filteredProduct/filter_product_event.dart';
import 'package:apple_shop/BLoC/filteredProduct/filterproduct_bloc.dart';
import 'package:apple_shop/BLoC/filteredProduct/filterproduct_state.dart';
import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:apple_shop/widgets/product_item_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatelessWidget {
  const CategoryProductScreen({super.key, required this.categoryItem});
  final Category categoryItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var filterBloc = FilterProductBloc(locator.get());
        filterBloc.add(
          FilterProductDataRequestEvent(categoryItem.id!),
        );
        return filterBloc;
      },
      child: MainBody(categoryItem: categoryItem),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key, required this.categoryItem});
  final Category categoryItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<FilterProductBloc, FilterProductState>(
          builder: (context, state) {
            if (state is FitlerProductLoadingState) {
              return const LoadingAnimation(
                color: ShopColors.blueColor,
              );
            }
            if (state is FilterProductResponseState) {
              return CustomScrollView(
                slivers: [
                  _AppBar(categoryTitle: categoryItem.title ?? "محصول"),
                  state.productList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(exceptionMessage),
                        ),
                      );
                    },
                    (productList) {
                      return _ProductList(
                        productList: productList,
                      );
                    },
                  ),
                ],
              );
            } else {
              return const BlocErrorMessage();
            }
          },
        ),
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.productList});
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductItemChip(
              productItem: productList[index],
            );
          },
          childCount: productList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.7,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.categoryTitle});
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 46,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_apple_blue.png"),
                Text(
                  categoryTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('images/icon_back.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
