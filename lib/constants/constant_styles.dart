import 'package:flutter/material.dart';
import 'constant_colors.dart';

class StyleConstants {
  static const int autoScrollIntervalSeconds = 3;
  static const int carouselAnimationDurationMs = 350;
  static const double carouselHeightRatio = 0.4;
  static const double carouselItemWidthRatio = 0.9;
  static const double carouselItemHeightRatio = 0.3;
  static const double carouselBorderRadius = 30.0;
  static const double carouselItemPadding = 19.0;

  static const double pageIndicatorPaddingVertical = 16.0;
  static const double pageIndicatorHeight = 5.0;
  static const double pageIndicatorBorderRadius = 30.0;
  static const double pageIndicatorSpacing = 4.0;
  static const double pageIndicatorWidthOffset = 32.0;

  static const double carouselSpacing = 8.0;
  static const double priceContainerBorderRadius = 20.0;
  static const double carouselImageTopPosition = 0.0;
  static const double carouselImageRadius = 70.0;
  static const double priceContainerPadding = 10.0;


  static const TextStyle recipeNameTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorConstants.textWhite,
  );

  static const TextStyle priceTextStyle = TextStyle(
    fontSize: 16,
    color: ColorConstants.textWhite,
  );

  static const TextStyle floatingActionButtonTextStyle = TextStyle(
    color: ColorConstants.textWhite,
  );

  static const BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: ColorConstants.cardPriceBackground,
  );

  static const BoxDecoration gradientBackgroundDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    gradient: LinearGradient(
      colors: [ColorConstants.gradientStart, ColorConstants.gradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(19.0);
}
