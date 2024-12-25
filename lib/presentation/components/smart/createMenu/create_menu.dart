import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/presentation/components/smart/createMenu/controller.dart';
import 'package:projects/utils/mediaquery.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class CreateMenuWidget extends ConsumerStatefulWidget {
  const CreateMenuWidget({super.key});

  @override
  CreateMenuWidgetState createState() => CreateMenuWidgetState();
}

class CreateMenuWidgetState extends ConsumerState<CreateMenuWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    ref.read(createMenuController).animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controllerProvider = ref.watch(createMenuController);

    return controllerProvider.hideMenu
        ? const SizedBox.shrink()
        : AnimatedBuilder(
            animation: controllerProvider.animationController,
            builder: (context, _) {
              return Positioned(
                bottom: controllerProvider.bgBottomPosition(),
                right: 0,
                left: 0,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: controllerProvider.toggleModalStatus,
                      child: Container(
                        width: fullWidth(context),
                        height: fullHeight(context),
                        color: AppColors.kBlack.withValues(alpha: 0.1),
                      ),
                    ),
                    Positioned(
                      bottom: controllerProvider.bottomPosition(),
                      left: controllerProvider.horizontalPosition(),
                      right: controllerProvider.horizontalPosition(),
                      child: Column(
                        spacing: 20,
                        children: [
                          //* Expanded state close button
                          Visibility(
                            visible: !controllerProvider.isModalCollapsed,
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.kGrey,
                                borderRadius: BorderRadius.circular(
                                  100,
                                ),
                              ),
                              child: IconButton(
                                onPressed:
                                    controllerProvider.fullyCollapseModal,
                                icon: const Icon(Icons.clear),
                                color: AppColors.kWhite,
                              ),
                            ).animate().scale(duration: 200.ms),
                          ),

                          //* Expanded state menu items
                          Container(
                            height: controllerProvider.modalHeight(),
                            width: controllerProvider.modalWidth(),
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kBlack.withValues(alpha: .1),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  controllerProvider.isModalCollapsed ? 10 : 25,
                                ),
                                topRight: Radius.circular(
                                  controllerProvider.isModalCollapsed ? 10 : 25,
                                ),
                                bottomLeft: Radius.circular(
                                  controllerProvider.isModalCollapsed ? 10 : 0,
                                ),
                                bottomRight: Radius.circular(
                                  controllerProvider.isModalCollapsed ? 10 : 0,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Visibility(
                              visible: controllerProvider.isModalCollapsed,
                              replacement: controllerProvider.currentPage,
                              child: _MenuList(
                                getLoopAnimation:
                                    controllerProvider.isModalCollapsed,
                                key: UniqueKey(),
                              ),
                            ),
                          )
                              .animate(
                                target: controllerProvider.isModalOpen ? 1 : 0,
                              )
                              .scale(
                                duration: 300.ms,
                                curve: controllerProvider.isModalOpen
                                    ? Curves.bounceInOut
                                    : null,
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class _MenuList extends StatefulWidget {
  const _MenuList({required this.getLoopAnimation, super.key});
  final bool getLoopAnimation;

  @override
  State<_MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<_MenuList> {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': RiveIcon.add,
        'title': 'Create a post',
        'menuType': MenuPageState.post,
      },
      {
        'icon': RiveIcon.sound,
        'title': 'Start an audio room',
        'menuType': MenuPageState.room,
      },
      {
        'icon': RiveIcon.gallery,
        'title': 'Go live',
        'menuType': MenuPageState.live,
      },
    ];

    return Material(
      color: Colors.transparent,
      child: Column(
        children: menuItems
            .map((item) {
              return Consumer(
                builder: (context, ref, _) {
                  final controllerProvider = ref.read(createMenuController);
                  return ListTile(
                    leading: RiveAnimatedIcon(
                      key: ValueKey(item['title']),
                      height: 30,
                      width: 30,
                      loopAnimation: widget.getLoopAnimation,
                      riveIcon: item['icon']! as RiveIcon,
                      color: Colors.green,
                      strokeWidth: 3,
                    ),
                    title: TextView(
                      text: item['title']! as String,
                    ),
                    onTap: () => controllerProvider.setPage(
                      item['menuType']! as MenuPageState,
                    ),
                  );
                },
              );
            })
            .toList()
            .animate(interval: 100.ms)
            .fade(duration: 50.ms),
      ),
    );
  }
}
