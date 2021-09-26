import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? extraLargeScreen,
      largeScreen,
      smallScreen,
      extraSmallScreen,
      tabScreen,
      mobileScreen;

  const Responsive({
    Key? key,
    this.extraLargeScreen,
    this.largeScreen,
    this.smallScreen,
    this.extraSmallScreen,
    this.tabScreen,
    this.mobileScreen,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design
  static bool isMobileScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 769 &&
      MediaQuery.of(context).size.width > 300;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 1025 &&
      MediaQuery.of(context).size.width >= 769;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1025;
  // static bool isSmallScreen(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1201 &&
  //     MediaQuery.of(context).size.width < 1366;
  // static bool isLargeScreen(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1366 &&
  //     MediaQuery.of(context).size.width < 1536;
  // static bool isExtraLargeScreen(BuildContext context) =>
  //     MediaQuery.of(context).size.width >= 1536;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1201) {
          return largeScreen!;
        }
        //for extra small screen
        else if (constraints.maxWidth >= 1025) {
          return extraSmallScreen!;
        } //for tab screen
        else if (constraints.maxWidth >= 769) {
          return tabScreen!;
        }
        //for extra Screen
        else {
          return extraSmallScreen!;
        }
      },
    );
  }
}
