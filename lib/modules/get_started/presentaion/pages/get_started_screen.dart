import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/resourses/assets_manager.dart';
import 'package:wallpaper_app/core/resourses/values_manager.dart';

import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';
import '../../../../core/resourses/strings_manager.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImageAssets.startImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p24, vertical: AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.firstScreenWelcomeText,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSize.s30),
                SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutesName.home,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      AppStrings.exploreNow,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColor.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: AppSize.s24),
        ],
      ),
    );
  }
}
