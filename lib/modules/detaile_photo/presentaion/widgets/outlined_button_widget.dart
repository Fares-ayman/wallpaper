import 'package:flutter/material.dart';

import '../../../../core/resourses/values_manager.dart';

// ignore: must_be_immutable
class OutlinedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  Color? backgroundColor;
  final Widget icon;
  final String btnText;
  final Color btnTextColor;
  OutlinedButtonWidget({
    super.key,
    this.backgroundColor,
    required this.btnTextColor,
    required this.onPressed,
    required this.icon,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(AppPadding.p16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
      ),
      icon: icon,
      label: Text(
        btnText,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: btnTextColor),
      ),
    );
  }
}
