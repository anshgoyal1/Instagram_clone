import 'package:flutter/material.dart';
import 'package:fluttergram/responsive_layout/web_screen_layout.dart';
import 'package:fluttergram/utils/dimensions.dart';

import 'mobile_screen_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return WebScreenLayout();
        } else {
          return MobileScreenLayout();
        }
        //mobile screen
      }),
    );
  }
}
