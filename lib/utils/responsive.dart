import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {required this.mobile,

        required this.desktop,
        Key? key})
      : super(key: key);

  final Widget mobile;
  final Widget desktop;


  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 690;



  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 650) {
          return desktop;

        } else {
          return mobile;
        }
      },
    );
  }
}
