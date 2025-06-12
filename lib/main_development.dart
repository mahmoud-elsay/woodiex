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

  bool isFirstLaunch = await SharedPrefHelper.isFirstLaunch();
  bool isLoggedIn = isFirstLaunch ? false : await checkIfLoggedInUser();

  final initialRoute = isFirstLaunch
      ? Routes.onBoardingScreen
      : (isLoggedIn ? Routes.appLayout : Routes.loginScreen);

  runApp(
    ProviderScope(
      child: App(initialRoute: initialRoute),
    ),
  );
}

Future<bool> checkIfLoggedInUser() async {
  String token = await SharedPrefHelper.getUserToken();
  return token.isNotEmpty;
}

class App extends StatelessWidget {
  final String initialRoute;

  const App({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: (context, child) => AppConnectivity(child: child!),
          home: Woodiex(
            appRouter: AppRouter(),
            initialRoute: initialRoute,
          ),
        );
      },
    );
  }
}
