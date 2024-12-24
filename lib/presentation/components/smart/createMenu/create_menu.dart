import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/common/src/components.dart';
import 'package:projects/common/src/config.dart';
import 'package:projects/presentation/components/smart/createMenu/controller.dart';
import 'package:projects/utils/mediaquery.dart';

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
                          GestureDetector(
                            onTap: controllerProvider.fullyExpandModal,
                            child: Container(
                              height: controllerProvider.modalHeight(),
                              width: controllerProvider.modalWidth(),
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.kBlack.withValues(alpha: .1),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  topRight: const Radius.circular(10),
                                  bottomLeft: Radius.circular(
                                    controllerProvider.isModalCollapsed
                                        ? 10
                                        : 0,
                                  ),
                                  bottomRight: Radius.circular(
                                    controllerProvider.isModalCollapsed
                                        ? 10
                                        : 0,
                                  ),
                                ),
                              ),
                            )
                                .animate(
                                  target:
                                      controllerProvider.isModalOpen ? 1 : 0,
                                )
                                .scale(duration: 100.ms),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  .animate(target: controllerProvider.isModalOpen ? 1 : 0)
                  .fade(duration: 200.ms);
            },
          );
  }
}
