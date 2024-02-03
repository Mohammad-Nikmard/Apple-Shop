import 'package:apple_shop/BLoC/home/home_bloc.dart';
import 'package:apple_shop/BLoC/home/home_event.dart';
import 'package:apple_shop/BLoC/home/home_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/ui/hot_Items_screen.dart';
import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/category_chip.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:apple_shop/widgets/product_item_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const LoadingAnimation(
                color: ShopColors.blueColor,
              );
            }
            if (state is HomeResponseState) {
              return RefreshIndicator(
                backgroundColor: Colors.white,
                color: ShopColors.blueColor,
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeDataRequestEvent());
                },
                child: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      const SearchBox(),
                      state.bannerList.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exceptionMessage),
                            ),
                          );
                        },
                        (bannerList) {
                          return BannerSlider(bannerList: bannerList);
                        },
                      ),
                      _categoryHeader(),
                      state.categoryList.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exceptionMessage),
                            ),
                          );
                        },
                        (categoryList) {
                          return CategoryChipList(categoryList: categoryList);
                        },
                      ),
                      state.bestSellerProductList.fold(
                        (exceptionMessage) {
                          return _categoryHeader();
                        },
                        (bestSellerList) {
                          return BestSellerHeader(productList: bestSellerList);
                        },
                      ),
                      state.bestSellerProductList.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exceptionMessage),
                            ),
                          );
                        },
                        (bestSellerList) {
                          return BestSellerItems(productList: bestSellerList);
                        },
                      ),
                      state.hotestproductList.fold(
                        (exceptionMessage) {
                          return _categoryHeader();
                        },
                        (bestSellerList) {
                          return MostViewedHeader(productList: bestSellerList);
                        },
                      ),
                      state.hotestproductList.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(exceptionMessage),
                            ),
                          );
                        },
                        (hotestList) {
                          return MostViewedItems(productList: hotestList);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return const BlocErrorMessage();
          },
        ),
      ),
    );
  }
}

Widget _categoryHeader() {
  return const SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(right: 25, left: 25, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "دسته بندی",
            style: TextStyle(
              fontFamily: "SB",
              fontSize: 12,
              color: ShopColors.greyColor,
            ),
          ),
        ],
      ),
    ),
  );
}

class BestSellerHeader extends StatelessWidget {
  const BestSellerHeader({super.key, required this.productList});
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 25, left: 25, bottom: 20, top: 31),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotItemsScreen(
                      categoryTitle: "پرفروش ترین ها",
                      productList: productList,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('images/icon_left_categroy.png'),
                  const SizedBox(width: 10),
                  const Text(
                    "مشاهده همه",
                    style: TextStyle(
                      fontFamily: "SB",
                      fontSize: 12,
                      color: ShopColors.blueColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "پرفروش ترین ها",
              style: TextStyle(
                fontFamily: "SB",
                fontSize: 12,
                color: ShopColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MostViewedHeader extends StatelessWidget {
  const MostViewedHeader({super.key, required this.productList});
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotItemsScreen(
                      categoryTitle: "پربازدید ترین ها",
                      productList: productList,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset('images/icon_left_categroy.png'),
                  const SizedBox(width: 10),
                  const Text(
                    "مشاهده همه",
                    style: TextStyle(
                      fontFamily: "SB",
                      fontSize: 12,
                      color: ShopColors.blueColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text(
              "پربازدید ترین ها",
              style: TextStyle(
                fontFamily: "SB",
                fontSize: 12,
                color: ShopColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key, required this.categoryList});
  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 87,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CategoryChip(
                    categoryItem: categoryList[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 46,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset("images/icon_apple_blue.png"),
                  const Spacer(),
                  const Text(
                    "جستجوی محصولات",
                    style: TextStyle(
                      fontFamily: "SB",
                      fontSize: 16,
                      color: ShopColors.greyColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset("images/icon_search.png"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BestSellerItems extends StatelessWidget {
  const BestSellerItems({super.key, required this.productList});
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 248,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ProductItemChip(productItem: productList[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MostViewedItems extends StatelessWidget {
  const MostViewedItems({super.key, required this.productList});
  final List<Product> productList;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 248,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: productList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ProductItemChip(productItem: productList[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
