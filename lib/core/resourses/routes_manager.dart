import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/resourses/strings_manager.dart';
import 'package:wallpaper_app/modules/detaile_photo/presentaion/pages/favourite_screen.dart';

import '../../modules/detaile_photo/presentaion/pages/detail_photo_screen.dart';
import '../../modules/get_started/presentaion/pages/get_started_screen.dart';
import '../../modules/home/presentaion/pages/home_screen.dart';
import '../../modules/search/presentaion/pages/search_screen.dart';

class AppRoutesName {
  static const String getStarted = "/get-started";
  static const String home = "/home";
  static const String search = "/search";
  static const String detailPhoto = "/detail-photo";
  static const String favouritePhoto = "/favourite-photo";
}

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.getStarted:
        return MaterialPageRoute(
          builder: (_) => const GetStartedScreen(),
          settings: settings,
        );

      case AppRoutesName.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => HomeScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRoutesName.search:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => SearchScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRoutesName.detailPhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const DetailPhotoScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      case AppRoutesName.favouritePhoto:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const FavouriteScreen(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
