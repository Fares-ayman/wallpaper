import 'package:flutter/material.dart';

import '../../resourses/color_manager.dart';

void showInfoSnackBar(BuildContext context, String text) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColor.black.withOpacity(0.8),
        content: Text(text),
      ),
    );
  });
}
