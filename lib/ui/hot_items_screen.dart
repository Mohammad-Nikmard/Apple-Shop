import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/widgets/product_item_chip.dart';
import 'package:flutter/material.dart';

class HotItemsScreen extends StatelessWidget {
  const HotItemsScreen(
      {super.key, required this.categoryTitle, required this.productList});
  final String categoryTitle;
  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _AppBar(categoryTitle: categoryTitle),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ProductItemChip(
                    productItem: productList[index],
                  );
                }, childCount: productList.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.7,
                ),
              ),
            ),
          ],
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
