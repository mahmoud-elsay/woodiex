import 'package:woodiex/woodiex.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/widgets/app_connectivity.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();
  
  // Check first launch and login status
  bool isFirstLaunch = await SharedPrefHelper.isFirstLaunch();
  bool isLoggedIn = isFirstLaunch ? false : await checkIfLoggedInUser();
  
  // Determine initial route
  final initialRoute = isFirstLaunch
      ? Routes.onBoardingScreen
      : (isLoggedIn ? Routes.appLayout : Routes.loginScreen);

  runApp(
    ProviderScope(
      child: AppConnectivity(
        child: Woodiex(
          appRouter: AppRouter(),
          initialRoute: initialRoute,
        ),
      ),
    ),
  );
}

Future<bool> checkIfLoggedInUser() async {
  String token = await SharedPrefHelper.getUserToken();
  return token.isNotEmpty;
}