import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';

class NoNetWorkScreen extends StatelessWidget {
  const NoNetWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ColorsManager.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lotties/connection_lottie.json',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No Internet Connection',
                    style: Fonts.nunitoSans20BoldMainBlack,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please check your internet connection and try again',
                    style: Fonts.nunitoSans16RegularRed.copyWith(
                      color: ColorsManager.secondaryGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Retry logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlack,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: Fonts.nunitoSans16BoldWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
