import 'package:apple_shop/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.imageURL, this.radius = 0});
  final String imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageURL,
        placeholder: (context, url) {
          return Container(
            color: Colors.white,
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            color: ShopColors.redColor,
          );
        },
      ),
    );
  }
}
