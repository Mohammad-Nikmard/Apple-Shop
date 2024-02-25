import 'dart:ui';
import 'package:apple_shop/BLoC/basket/basket_bloc.dart';
import 'package:apple_shop/BLoC/basket/basket_event.dart';
import 'package:apple_shop/BLoC/comment/comment_bloc.dart';
import 'package:apple_shop/BLoC/comment/comment_event.dart';
import 'package:apple_shop/BLoC/comment/comment_state.dart';
import 'package:apple_shop/BLoC/product/product_bloc.dart';
import 'package:apple_shop/BLoC/product/product_event.dart';
import 'package:apple_shop/BLoC/product/product_state.dart';
import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/gallery.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/data/model/variants.dart';
import 'package:apple_shop/util/extensions/double_extension.dart';
import 'package:apple_shop/util/extensions/string_extension.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:apple_shop/widgets/percentage_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productItem});
  final Product productItem;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var productbloc = ProductBloc(locator.get(), locator.get());
        productbloc.add(ProductDataRequestEvent(
            widget.productItem.id!, widget.productItem.category!));
        return productbloc;
      },
      child: MainBody(widget: widget),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key, required this.widget});
  final ProductDetailScreen widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProdcutLoadingState) {
              return const LoadingAnimation(
                color: ShopColors.blueColor,
              );
            }
            if (state is ProductResponseState) {
              return CustomScrollView(
                slivers: [
                  state.categoryItem.fold(
                    (exception) {
                      return const _AppBar(
                        categorytitle: "محصول",
                      );
                    },
                    (categoryItem) {
                      return _AppBar(
                        categorytitle: categoryItem.title ?? "محصول",
                      );
                    },
                  ),
                  Header(header: widget.productItem.name),
                  state.imagesList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(exceptionMessage),
                        ),
                      );
                    },
                    (imagesList) {
                      return GalleryWidget(
                          images: imagesList,
                          productThumbnail: widget.productItem.thumbnail!);
                    },
                  ),
                  state.productVariantList.fold(
                    (exceptionMessage) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text(""),
                        ),
                      );
                    },
                    (productVariantList) {
                      return VariantGenerator(
                          productVaraintList: productVariantList);
                    },
                  ),
                  state.getProperties.fold(
                    (l) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text(""),
                        ),
                      );
                    },
                    (propertyList) {
                      return TechnicalSpesification(propertyList: propertyList);
                    },
                  ),
                  Description(
                    description: widget.productItem.description,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            builder: ((context) {
                              return DraggableScrollableSheet(
                                minChildSize: 0.4,
                                maxChildSize: 0.9,
                                initialChildSize: 0.6,
                                builder: (context, isScrolled) {
                                  return BlocProvider(
                                    create: (context) {
                                      var bloc = CommentBloc(locator.get());
                                      bloc.add(CommentInitativeEvent(
                                          widget.productItem.id!));
                                      return bloc;
                                    },
                                    child: CommentsSection(
                                      controller: isScrolled,
                                      productId: widget.productItem.id!,
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        },
                        child: Container(
                          height: 46,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: ShopColors.greyColor.withOpacity(0.6),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                        "images/icon_left_categroy.png"),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "مشاهده",
                                      style: TextStyle(
                                        fontFamily: "SB",
                                        fontSize: 12,
                                        color: ShopColors.blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 72),
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Image.asset('images/user.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 54),
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Image.asset('images/user.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 36),
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Image.asset('images/user.png'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Image.asset('images/user.png'),
                                      ),
                                    ),
                                    Container(
                                      height: 26,
                                      width: 26,
                                      decoration: const BoxDecoration(
                                        color: ShopColors.greyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "+10",
                                          style: TextStyle(
                                              fontFamily: "SB",
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  ":نظرات کاربران",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 25, left: 25, top: 34, bottom: 45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PriceTagButton(
                            discountPrice: widget.productItem.discountPrice,
                            price: widget.productItem.price,
                            percentage: widget.productItem.discountPercentage,
                          ),
                          AddToBasketButton(
                              item: widget.productItem.name ?? "محصول",
                              productItem: widget.productItem),
                        ],
                      ),
                    ),
                  ),
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

class PriceTagButton extends StatelessWidget {
  const PriceTagButton(
      {super.key,
      required this.discountPrice,
      required this.price,
      required this.percentage});
  final int? discountPrice;
  final int? price;
  final num? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 150,
          height: 47,
          decoration: const BoxDecoration(
            color: ShopColors.greenColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: -15,
          right: -15,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 170,
                height: 53,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            price.convertToPrice(),
                            style: const TextStyle(
                              fontFamily: "SM",
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            discountPrice.convertToPrice(),
                            style: const TextStyle(
                              fontFamily: "SM",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      PercentageChip(number: percentage ?? 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton(
      {super.key, required this.item, required this.productItem});
  final String item;
  final Product productItem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140,
          height: 47,
          decoration: const BoxDecoration(
            color: ShopColors.blueColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: -10,
          right: -10,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: GestureDetector(
                onTap: () {
                  context
                      .read<ProductBloc>()
                      .add(AddToBasketEvent(productItem));

                  context.read<BasketBloc>().add(ShowBasketItemsEvent());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SnackBarMessage(
                        item: item,
                      ),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 4),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  height: 53,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "افزودن به سبد خرید",
                      style: TextStyle(
                        fontFamily: "SB",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({super.key, required this.item});
  final String? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: ShopColors.greenColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                spreadRadius: -10,
                blurRadius: 25,
                color: Colors.black,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: Lottie.asset(
                          "assets/Animation - 1706633776054.json",
                          repeat: false,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item ?? "محصول",
                          style: const TextStyle(
                            fontFamily: "SB",
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          ".محصول مورد نظر به سبد خرید افزوده شد",
                          style: TextStyle(
                            fontFamily: "SB",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CommentsSection extends StatelessWidget {
  CommentsSection({
    super.key,
    required this.controller,
    required this.productId,
  });
  final ScrollController controller;
  final String productId;

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: ShopColors.greyBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentsLoadingState) {
              return const Center(
                child: LoadingAnimation(color: ShopColors.blueColor),
              );
            }
            if (state is CommentsResponseState) {
              return state.getComments.fold(
                (exceptionMessage) {
                  return const Center(
                    child: Text("خطا"),
                  );
                },
                (commentList) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Container(
                          height: 5,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: ShopColors.greyColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "نظرات",
                          style: TextStyle(
                            fontFamily: "SB",
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: commentList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 10),
                              child: Center(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "images/user.png",
                                            height: 36,
                                            width: 36,
                                          ),
                                          const SizedBox(width: 15),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // commentList[index].name ??
                                                  "کاربر",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    commentList[index].text ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontFamily: "SM",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            controller: _commentController,
                            maxLines: 2,
                            style: const TextStyle(
                              fontFamily: "SB",
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: "نظر خود را وارد کنید...",
                              hintStyle: TextStyle(
                                fontFamily: "SB",
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 46),
                            backgroundColor: ShopColors.greenColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          onPressed: () {
                            context.read<CommentBloc>().add(PostNewCommentEvent(
                                _commentController.text, productId));
                          },
                          child: const Text(
                            "ارسال نظر",
                            style: TextStyle(
                              fontFamily: "SB",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              );
            }
            return const BlocErrorMessage();
          },
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  const Description({super.key, required this.description});
  final String? description;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              child: Container(
                height: 46,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: ShopColors.greyColor.withOpacity(0.6),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset("images/icon_left_categroy.png"),
                          const SizedBox(width: 5),
                          Text(
                            (isTapped) ? "بستن" : "مشاهده",
                            style: const TextStyle(
                              fontFamily: "SB",
                              fontSize: 12,
                              color: ShopColors.blueColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        ":توضیحات محصول",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Visibility(
              visible: isTapped,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: ShopColors.greyColor.withOpacity(0.5),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.description ?? "",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontFamily: "SM",
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TechnicalSpesification extends StatefulWidget {
  const TechnicalSpesification({super.key, required this.propertyList});
  final List<ProductProperties> propertyList;

  @override
  State<TechnicalSpesification> createState() => _TechnicalSpesificationState();
}

class _TechnicalSpesificationState extends State<TechnicalSpesification> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              child: Container(
                height: 46,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: ShopColors.greyColor.withOpacity(0.6),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset("images/icon_left_categroy.png"),
                          const SizedBox(width: 5),
                          Text(
                            (isTapped) ? "بستن" : "مشاهده",
                            style: const TextStyle(
                              fontFamily: "SB",
                              fontSize: 12,
                              color: ShopColors.blueColor,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        ":مشخصات فنی ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Visibility(
              visible: isTapped,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: ShopColors.greyColor.withOpacity(0.5),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: widget.propertyList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Text(
                          "${widget.propertyList[index].title} : ${widget.propertyList[index].value}",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.header});
  final String? header;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: Text(
            header ?? "محصول",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class VariantGenerator extends StatelessWidget {
  const VariantGenerator({super.key, required this.productVaraintList});
  final List<ProductVariant> productVaraintList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var element in productVaraintList) ...{
              if (element.variantsList.isNotEmpty) ...{
                VariantGeneratorChild(productVaraint: element),
              }
            }
          ],
        ),
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  const VariantGeneratorChild({super.key, required this.productVaraint});
  final ProductVariant productVaraint;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              productVaraint.variantType.name!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            if (productVaraint.variantType.typeEnum ==
                VariantTypesEnum.color) ...{
              ColorVariants(
                  generatorChildVariants: productVaraint.variantsList),
            } else if (productVaraint.variantType.typeEnum ==
                VariantTypesEnum.storage) ...{
              StorageVariant(variantsList: productVaraint.variantsList),
            }
          ],
        ),
      ),
    );
  }
}

class StorageVariant extends StatefulWidget {
  const StorageVariant({super.key, required this.variantsList});
  final List<Variants> variantsList;

  @override
  State<StorageVariant> createState() => _StorageVariantState();
}

class _StorageVariantState extends State<StorageVariant> {
  int selectedIndexforStorage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.variantsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndexforStorage = index;
                  });
                },
                child: Container(
                  width: 74,
                  height: 26,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: (selectedIndexforStorage == index) ? 2 : 1,
                      color: (selectedIndexforStorage == index)
                          ? ShopColors.blueColor
                          : ShopColors.greyColor.withOpacity(0.5),
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.variantsList[index].value!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ColorVariants extends StatefulWidget {
  const ColorVariants({super.key, this.generatorChildVariants});
  final List<Variants>? generatorChildVariants;

  @override
  State<ColorVariants> createState() => _ColorVariantsState();
}

class _ColorVariantsState extends State<ColorVariants> {
  int selectedIndexforColors = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: widget.generatorChildVariants?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String? color = widget.generatorChildVariants![index].value;
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndexforColors = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                  height: 26,
                  width: (selectedIndexforColors == index) ? 77 : 26,
                  decoration: BoxDecoration(
                    color: color!.convertToHexColor(),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: AnimatedScale(
                    scale: (selectedIndexforColors == index) ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: Text(
                        widget.generatorChildVariants?[index].name ?? "",
                        style: const TextStyle(
                          fontFamily: "SM",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key, this.images, required this.productThumbnail});
  final List<GalleryImages>? images;
  final String productThumbnail;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int selectedIndexforGallery = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 284,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                spreadRadius: -10,
                blurRadius: 25,
                color: ShopColors.greyColor,
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/icon_star.png"),
                        const SizedBox(width: 5),
                        Text(
                          "4.6",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: CachedImage(
                            imageURL:
                                widget.images?[selectedIndexforGallery].image ??
                                    widget.productThumbnail,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Image.asset("images/icon_favorite_deactive.png"),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: SizedBox(
                          height: 70,
                          child: ListView.builder(
                            itemCount: widget.images?.length ?? 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndexforGallery = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: (selectedIndexforGallery == index)
                                        ? ShopColors.greyBackgroundColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      width: 1,
                                      color: ShopColors.greyColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CachedImage(
                                      imageURL: widget.images?[index].image ??
                                          widget.productThumbnail,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.categorytitle});
  final String categorytitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 32),
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
                  categorytitle,
                  style: const TextStyle(
                    fontFamily: "SB",
                    color: ShopColors.blueColor,
                    fontSize: 16,
                  ),
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
