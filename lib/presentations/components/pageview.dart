import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    required this.pageController,
    this.onPageChange,
    this.pages,
    this.height = 500,
    this.width = 400,
    this.scrollBehavior,
    this.pageSnapping = true,
    super.key,
  });

  final List<Widget>? pages;
  final ValueChanged<int>? onPageChange;
  final PageController pageController;
  final double height;
  final double width;
  final ScrollBehavior? scrollBehavior;
  final bool pageSnapping;

  @override
  Widget build(BuildContext context) {
    //
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: width,
      height: height,
      alignment: Alignment.center,
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        padEnds: false,
        scrollBehavior: scrollBehavior,
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: pageSnapping,
        children: pages!,
      ),
    );
  }
}
