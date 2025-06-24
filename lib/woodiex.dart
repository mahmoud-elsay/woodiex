import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/routing/app_router.dart';

class Woodiex extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const Woodiex({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woodiex',
      theme: ThemeData(
        primaryColor: ColorsManager.mainBlack,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false, // Ensure consistency
      initialRoute: initialRoute,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
