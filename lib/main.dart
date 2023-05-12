import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/core/resourses/routes_manager.dart';
import 'package:wallpaper_app/core/resourses/theme_manager.dart';
import 'package:wallpaper_app/modules/home/presentaion/providers/home_provider.dart';
import 'package:wallpaper_app/modules/search/presentaion/providers/search_provider.dart';
import 'injection_container.dart' as di;
import 'modules/detaile_photo/presentaion/providers/detail_photo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => di.sl<HomeProvider>(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => di.sl<SearchProvider>(),
        ),
        ChangeNotifierProvider<DetailPhotoProvider>(
          create: (_) => di.sl<DetailPhotoProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wellpaper',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: /*  SchedulerBinding.instance.window.platformBrightness ==
                Brightness.dark
            ? ThemeMode.dark
            : */
            ThemeMode.dark,
        initialRoute: AppRoutesName.getStarted,
        onGenerateRoute: AppRoute.generate,
      ),
    );
  }
}
