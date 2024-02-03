import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: [
              color,
            ],
          ),
        ),
      ),
    );
  }
}
