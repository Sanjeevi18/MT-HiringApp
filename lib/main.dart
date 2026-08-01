import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Do NOT await heavy synchronous tasks here.
  // Let the splash controller handle them asynchronously.
  runApp(const HiringApp());
}

class HiringApp extends StatelessWidget {
  const HiringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hiring App',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      // This ensures dependencies are lazy-loaded and disposed of when routes change
      smartManagement: SmartManagement.keepFactory,
    );
  }
}
