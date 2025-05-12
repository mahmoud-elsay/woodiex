import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Woodiex',
        theme: ThemeData(
          primaryColor: ColorsManager.mainBlack,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
