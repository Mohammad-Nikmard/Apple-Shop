import 'package:apple_shop/BLoC/basket/basket_bloc.dart';
import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/ui/product_detail_screen.dart';
import 'package:apple_shop/util/extensions/double_extension.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/percentage_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItemChip extends StatelessWidget {
  const ProductItemChip({super.key, required this.productItem});
  final Product productItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: ProductDetailScreen(productItem: productItem),
            ),
          ),
        );
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Container(
              height: 163,
              width: 170,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 97,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PercentageChip(
                                number: productItem.discountPercentage ?? 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 92,
                          child: Center(
                            child: CachedImage(
                              imageURL: productItem.thumbnail ?? "",
                            ),
                          ),
                        ),
                        Image.asset("images/icon_favorite_deactive.png"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    child: Text(
                      productItem.name ?? "محصول",
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: "SM",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 53,
              width: 170,
              decoration: const BoxDecoration(
                color: ShopColors.blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ShopColors.blueColor,
                    blurRadius: 25,
                    spreadRadius: -10,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  // vertical: 7,
                ),
                child: Row(
                  children: [
                    const Text(
                      "تومان",
                      style: TextStyle(
                        fontFamily: "SM",
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Text(
                          productItem.price.convertToPrice(),
                          style: const TextStyle(
                            fontFamily: "SM",
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          productItem.discountPrice.convertToPrice(),
                          style: const TextStyle(
                            fontFamily: "SM",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      "images/icon_right_arrow_cricle.png",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
