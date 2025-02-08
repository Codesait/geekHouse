import 'package:flutter/material.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    required this.itemCount,
    required this.currentPage,
    super.key,
  });

  final int itemCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: fullHeight(context),
        minWidth: 100,
        maxHeight: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buildPageIndicator(),
      ),
    );
  }

  // indicates current page
  List<Widget> buildPageIndicator() {
    final list = <Widget>[];

    /// Creating a list of 3 PageIndicator widgets.
    for (var i = 0; i < itemCount; i++) {
      list.add(
        i == currentPage
            ? const PageIndicator(isActive: true)
            : PageIndicator(
                isActive: false,
                isMainPage: i == 0,
              ),
      );
    }
    return list.toList();
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.isActive,
    this.isMainPage = false,
    super.key,
  });

  final bool isActive;
  final bool isMainPage;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 20,
        width: 20,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.kPrimary.withValues(alpha: .2),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          border: Border.all(),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.kGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
      );
    } else {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: AppColors.kPrimary.withValues(alpha: .6),
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
        ),
      );
    }
  }
}
