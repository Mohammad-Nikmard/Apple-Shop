import 'package:apple_shop/BLoC/category/category_bloc.dart';
import 'package:apple_shop/BLoC/category/category_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/ui/category_product_screen.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const LoadingAnimation(
                color: ShopColors.blueColor,
              );
            }
            if (state is CategoryResponseState) {
              return CustomScrollView(
                slivers: [
                  const _AppBar(),
                  state.getCategories.fold((exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(exceptionMessage),
                      ),
                    );
                  }, (apiList) {
                    return CategoryList(
                      categoryList: apiList,
                    );
                  }),
                ],
              );
            }
            return const BlocErrorMessage();
          },
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 46,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_apple_blue.png"),
                Text(
                  "دسته بندی",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categoryList});
  final List<Category> categoryList;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductScreen(
                      categoryItem: categoryList[index],
                    ),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: CachedImage(
                  imageURL: categoryList[index].thumbnail ?? "",
                  radius: 15,
                ),
              ),
            );
          },
          childCount: categoryList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
