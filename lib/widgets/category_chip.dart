import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/ui/category_product_screen.dart';
import 'package:apple_shop/util/extensions/string_extension.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.categoryItem});
  final Category categoryItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryProductScreen(categoryItem: categoryItem),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: ShapeDecoration(
              color: "${categoryItem.color}".convertToHexColor(),
              shadows: [
                BoxShadow(
                  spreadRadius: -12,
                  blurRadius: 25,
                  color: "${categoryItem.color}".convertToHexColor(),
                  offset: const Offset(0, 10),
                ),
              ],
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(45),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 26,
                  width: 26,
                  child: Center(
                    child: CachedImage(
                      imageURL: categoryItem.icon ?? "",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            categoryItem.title ?? "محصول",
            style: const TextStyle(
              fontFamily: "SB",
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
