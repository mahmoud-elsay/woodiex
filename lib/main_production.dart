import 'package:woodiex/woodiex.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isFirstLaunch = await SharedPrefHelper.isFirstLaunch();
  bool isLoggedIn = isFirstLaunch ? false : await checkIfLoggedInUser();

  runApp(
    ProviderScope(
      child: Woodiex(
        appRouter: AppRouter(),
        initialRoute: isFirstLaunch
            ? Routes.onBoardingScreen
            : (isLoggedIn ? Routes.appLayout : Routes.loginScreen),
      ),
    ),
  );
}

Future<bool> checkIfLoggedInUser() async {
  String token = await SharedPrefHelper.getUserToken();
  return token.isNotEmpty;
}
