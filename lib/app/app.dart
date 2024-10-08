import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venuevendor/app/themes/app_theme.dart';
import 'package:venuevendor/features/auth/internet/internet_checker_view.dart';
import 'package:venuevendor/features/book/presentation/view/booking_view.dart';
import 'package:venuevendor/features/profile/presentation/view/profile_view.dart';
import 'package:venuevendor/screen/dashboard_screen.dart';
import 'package:venuevendor/screen/presentation/view/bottom_view/dashboard_view.dart';

import '../features/splash/presentation/view/splash_view.dart';
import 'navigator_key/navigator_key.dart';


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: AppTheme.getApplicationTheme(false),
      home: const DashboardView(),
    );
  }
}
