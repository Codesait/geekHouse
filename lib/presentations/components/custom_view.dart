import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projects/commons/src/components.dart';
import 'package:projects/commons/src/config.dart';
import 'package:projects/utils/mediaquery.dart';

class ContentView extends StatelessWidget {
  const ContentView({
    required this.pageTitle,
    required this.body,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.appBarTrailing,
    super.key,
  });
  final String pageTitle;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? appBarTrailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const _BackBtn(),
        title: TextView(
          text: pageTitle,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: appBarTrailing,
      ),
      body: Container(
        height: fullHeight(context),
        width: fullWidth(context),
        padding: padding,
        child: body,
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();

  @override
  Widget build(BuildContext context) {
    return context.canPop()
        ? GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.kPrimary.withOpacity(.3),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
