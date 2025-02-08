
import 'package:flutter/material.dart';
import 'package:projects/common/src/config.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({
    required this.interestName,
    required this.isSelected,
    required this.onSelected, super.key,
  });
  final String interestName;
  final bool isSelected;
  final void Function({required bool isChecked}) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChoiceChip(
      label: Text(interestName),
      pressElevation: 3,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.kPrimary,
      ),
      selected: isSelected,
      selectedColor: AppColors.kPrimary,
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.kGrey : AppColors.kPrimary,
        ),
      ),
      onSelected:(value)=> onSelected(isChecked: value),
    );
  }
}
