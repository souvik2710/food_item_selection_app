import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_app_demo/single_food_item.dart';
import 'package:food_app_demo/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets/custom_network_cached_widget.dart';
import 'constants/constant_colors.dart';
import 'constants/constant_styles.dart';


class CarouselExample extends StatefulHookConsumerWidget {
  const CarouselExample({super.key});

  @override
  CarouselExampleState createState() => CarouselExampleState();
}

class CarouselExampleState extends ConsumerState<CarouselExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);

    // Watch
    final foodList = ref.watch(foodDeliveryViewModel).foodItems.where((e) => e.hitsOfTheWeek == true).toList();

    // Set up the timer for auto-scrolling if foodList is not empty
    useEffect(() {
      if (foodList.isNotEmpty) {
        final timer = Timer.periodic(const Duration(seconds: StyleConstants.autoScrollIntervalSeconds), (timer) {
          currentIndex.value = (currentIndex.value + 1) % foodList.length;
          pageController.animateToPage(
            currentIndex.value,
            duration: const Duration(milliseconds: StyleConstants.carouselAnimationDurationMs),
            curve: Curves.easeIn,
          );
        });

        return timer.cancel;
      }
      return null;
    }, [foodList]);// This will re-run when foodList changes

    return foodList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Container(
      height: MediaQuery.of(context).size.height * StyleConstants.carouselHeightRatio,
      color: ColorConstants.carouselBackgroundColor,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) => setState(() {
                  currentIndex.value = index;
                }),
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  final recipe = foodList[index];

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SingleFoodItemDetails(foodItems: recipe);
                          },
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * StyleConstants.carouselItemWidthRatio,
                          height: MediaQuery.of(context).size.height * StyleConstants.carouselItemHeightRatio,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(StyleConstants.carouselBorderRadius),
                            gradient: const LinearGradient(
                              colors: [
                                ColorConstants.carouselGradientStartColor,
                                ColorConstants.carouselGradientEndColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(StyleConstants.carouselItemPadding),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    recipe.recipeName,
                                    style: StyleConstants.recipeNameTextStyle,
                                  ),
                                  const SizedBox(height: StyleConstants.carouselSpacing),
                                  Container(
                                    padding: const EdgeInsets.all(StyleConstants.priceContainerPadding),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.priceContainerBackgroundColor,
                                      borderRadius: BorderRadius.circular(StyleConstants.priceContainerBorderRadius),
                                    ),
                                    child: Text(
                                      "\$${recipe.price.toStringAsFixed(2)}",
                                      style: StyleConstants.priceTextStyle,
                                    ),
                                  ),
                                  const SizedBox(width: StyleConstants.carouselSpacing)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Positioned circular image on top
                      Positioned(
                        top: StyleConstants.carouselImageTopPosition,
                        child: CircularCachedNetwork(
                          radius: StyleConstants.carouselImageRadius,
                          imageUrl: recipe.imageUrl,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: StyleConstants.pageIndicatorPaddingVertical),
              child: SizedBox(
                height: StyleConstants.pageIndicatorHeight,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: (MediaQuery.of(context).size.width - StyleConstants.pageIndicatorWidthOffset) / foodList.length,
                    height: StyleConstants.pageIndicatorHeight,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(StyleConstants.pageIndicatorBorderRadius),
                      color: index == currentIndex.value
                          ? ColorConstants.pageIndicatorSelectedColor
                          : ColorConstants.pageIndicatorUnselectedColor,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(width: StyleConstants.pageIndicatorSpacing),
                  itemCount: foodList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
