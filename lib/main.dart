import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_app/core/bindings/initial_binding.dart';
import 'package:football_app/core/theme/app_theme.dart';
import 'package:football_app/routes/app_pages.dart';
import 'package:football_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      title: 'Football App',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}