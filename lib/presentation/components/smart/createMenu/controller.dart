import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projects/common/src/utils.dart';
import 'package:projects/main.dart';

final createMenuController =
    ChangeNotifierProvider((ref) => CreateMenuController());

/// A controller for managing the state and animation of a modal menu.
class CreateMenuController extends ChangeNotifier {
  /// The animation controller used to control the modal's animation.
  late AnimationController animationController;

  /// The minimum height of the modal.
  final modalMinHeight = 200.0;

  /// The maximum height of the modal, calculated as 70% of the full screen height.
  final modalMaxHeight = fullHeight(rootNavigatorKey.currentContext!) * .7;

  /// The minimum width of the modal, calculated as two-thirds of the full screen width.
  final modalMinWidth = fullWidth(rootNavigatorKey.currentContext!) / 1.5;

  /// The maximum width of the modal, equal to the full screen width.
  final modalMaxWidth = fullWidth(rootNavigatorKey.currentContext!);

  /// The animation curve used for modal animations.
  final curve = Curves.easeOut;

  /// The duration of the modal animations.
  final duration = const Duration(milliseconds: 200);

  /// Linearly interpolates between [min] and [max] based on the current animation value.
  ///
  /// Returns the interpolated value or `null` if the animation controller is not initialized.
  double? lerp(double min, double max) =>
      lerpDouble(min, max, animationController.value);

  /// Calculates the current height of the modal based on the animation value.
  ///
  /// Returns the interpolated height or `null` if the animation controller is not initialized.
  double? modalHeight() => lerp(modalMinHeight, modalMaxHeight);

  /// Calculates the current width of the modal based on the animation value.
  ///
  /// Returns the interpolated width or `null` if the animation controller is not initialized.
  double? modalWidth() => lerp(modalMinWidth, modalMaxWidth);

  /// Calculates the current horizontal position of the modal based on the animation value.
  ///
  /// Returns the interpolated horizontal position or `null` if the animation controller is not initialized.
  double? horizontalPosition() => lerp(50, 0);

  /// Calculates the current bottom position of the modal based on the animation value.
  ///
  /// Returns the interpolated bottom position or `null` if the animation controller is not initialized.
  double? bottomPosition() => lerp(10, 0);

  /// Calculates the current background bottom position of the modal based on the animation value.
  ///
  /// Returns the interpolated background bottom position or `null` if the animation controller is not initialized.
  double? bgBottomPosition() => lerp(90, 0);

  /// Indicates whether the modal is currently open.
  bool _isModalOpen = false;

  /// Returns `true` if the modal is open, otherwise `false`.
  bool get isModalOpen => _isModalOpen;

  /// Indicates whether the menu should be hidden.
  bool _hideMenu = false;

  /// Returns `true` if the menu is hidden, otherwise `false`.
  bool get hideMenu => _hideMenu;

  /// Toggles the modal's open status and updates the menu visibility accordingly.
  ///
  /// If the modal is closed, the menu will be hidden after a delay.
  Future<void> toggleModalStatus() async {
    _isModalOpen = !_isModalOpen;

    if (!_isModalOpen) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _hideMenu = true;
        animationController.reset();
        notifyListeners();
      });
    } else {
      _hideMenu = false;
    }
    notifyListeners();
  }

  /// Returns `true` if the modal is fully collapsed, otherwise `false`.
  bool get isModalCollapsed => animationController.value == 0;

  /// Expands the modal to its full size.
  ///
  /// Animates the modal to the expanded state and notifies listeners.
  void fullyExpandModal() {
    animationController.animateTo(1, curve: curve, duration: duration);
    notifyListeners();
  }

  /// Collapses the modal to its minimum size.
  ///
  /// Animates the modal to the collapsed state.
  void fullyCollapseModal() {
    animationController.animateTo(0, curve: curve, duration: duration);
  }
}
