import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? extraSmallScreen, smallScreen, mediumScreen, largeScreen;

  const Responsive({
    Key? key,
    this.extraSmallScreen,
    this.smallScreen,
    this.mediumScreen,
    this.largeScreen,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  static bool isXS(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  static bool isSM(BuildContext context) =>
      MediaQuery.of(context).size.width < 992 &&
      MediaQuery.of(context).size.width >= 768;
  static bool isMD(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 992;
  static bool isLG(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // for larger Screeen
        if (constraints.maxWidth >= 1200) {
          return largeScreen!;
        }
        // for medium Screen
        else if (constraints.maxWidth >= 992) {
          return mediumScreen!;
        }
        //for small Screen
        else if (constraints.maxWidth >= 768) {
          return smallScreen!;
        }
        //for extra Screen
        else {
          return extraSmallScreen!;
        }
      },
    );
  }
}
