import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';

class PercentageChip extends StatelessWidget {
  const PercentageChip({super.key, required this.number});
  final num? number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      decoration: const BoxDecoration(
        color: ShopColors.redColor,
        borderRadius: BorderRadius.all(
          Radius.circular(7.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 2,
          left: 5,
          right: 5,
        ),
        child: Text(
          "%${number!.round().toString()}",
          style: const TextStyle(
            fontFamily: "SB",
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
