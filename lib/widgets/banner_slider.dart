import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key, required this.bannerList});
  final List<BannerModel> bannerList;

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller =
      PageController(viewportFraction: 0.9, initialPage: 1);
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SizedBox(
              height: 177,
              child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 177,
                    width: query.size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: CachedImage(
                        imageURL: widget.bannerList[index].thumbnail ?? "",
                        radius: 15,
                      ),
                    ),
                  );
                },
                itemCount: widget.bannerList.length,
              ),
            ),
            Positioned(
              bottom: 8,
              child: SmoothPageIndicator(
                controller: _controller, // PageController
                count: widget.bannerList.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 6,
                  spacing: 5,
                  dotHeight: 6,
                  dotWidth: 6,
                  dotColor: Colors.white,
                  activeDotColor: ShopColors.blueColor,
                ), // your preferred effect
              ),
            ),
          ],
        ),
      ),
    );
  }
}
