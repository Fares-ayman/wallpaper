import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/resourses/routes_manager.dart';
import 'package:wallpaper_app/core/resourses/theme_manager.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wellpaper App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutesName.getStarted,
      onGenerateRoute: AppRoute.generate,
    );
  }
}
