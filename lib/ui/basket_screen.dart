import 'package:apple_shop/BLoC/basket/basket_bloc.dart';
import 'package:apple_shop/BLoC/basket/basket_event.dart';
import 'package:apple_shop/BLoC/basket/basket_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_card.dart';
import 'package:apple_shop/util/extensions/double_extension.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:apple_shop/widgets/percentage_chip.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  void initState() {
    BlocProvider.of<BasketBloc>(context).add(ShowBasketItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            if (state is BasketLoadingState) {
              return const LoadingAnimation(
                color: ShopColors.blueColor,
              );
            }
            if (state is BasketResponseState) {
              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  CustomScrollView(
                    slivers: [
                      const _AppBar(),
                      BasketList(cardList: state.cardItems),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 53),
                        backgroundColor: ShopColors.greenColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        context.read<BasketBloc>().add(PaymentRequestEvent());
                      },
                      child: Text(
                        (state.finalPrice == 0)
                            ? "سبد خرید خالی است"
                            : "پرداخت : ${state.finalPrice.convertToPrice()}",
                        style: const TextStyle(
                          fontFamily: "SB",
                          fontSize: 16,
                          color: Colors.white,
                        ),
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

class BasketList extends StatelessWidget {
  const BasketList({super.key, required this.cardList});
  final List<BasketCard> cardList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 55),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BasketItem(cardItem: cardList[index], index: index),
            );
          },
          childCount: cardList.length,
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
                  "سبد خرید",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BasketItem extends StatelessWidget {
  const BasketItem({super.key, required this.cardItem, required this.index});
  final BasketCard cardItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 238,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: -15,
              blurRadius: 25,
              color: ShopColors.greyColor,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            cardItem.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "گارانتی 18 ماه مدیا پردازش",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PercentageChip(number: cardItem.percentageAmount),
                            const SizedBox(width: 5),
                            Text(
                              cardItem.price.convertToPrice(),
                              style: const TextStyle(
                                fontFamily: "SM",
                                fontSize: 12,
                                color: ShopColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // spacing: 10,
                          children: [
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: ShopColors.greyBackgroundColor,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "ذخیره",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset('images/active_fav_product.png',
                                        height: 15, width: 15),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: ShopColors.greyBackgroundColor,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(DeleteItemsEvent(index));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: SnackBarMessage(
                                                item: cardItem.title),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            duration:
                                                const Duration(seconds: 3),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "حذف",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset('images/icon_trash.png',
                                        height: 15, width: 15),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: ShopColors.greyBackgroundColor,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    "1",
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  const SizedBox(width: 18),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CachedImage(
                          imageURL: cardItem.thumbnail,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: double.infinity,
                lineThickness: 2.0,
                dashLength: 4.0,
                dashColor: ShopColors.greyColor.withOpacity(0.5),
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "تومان",
                    style: TextStyle(
                      fontFamily: "SM",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    cardItem.discountPrice.convertToPrice(),
                    style: const TextStyle(
                      fontFamily: "SM",
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
            color: ShopColors.blueColor,
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
                          "assets/Animation - 1706768382045.json",
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
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          ".محصول مورد نظر از سبد خرید حذف شد",
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
