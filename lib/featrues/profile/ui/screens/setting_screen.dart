import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/password_info.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/help_center_widget.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/pesonal_info_widget.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/notifications_widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'setting'),
              verticalSpace(20),
              PersonalInfoWidget(),
              verticalSpace(35),
              PasswordInfo(),
              verticalSpace(35),
              NotificationsWidgets(),
              verticalSpace(20),
              HelpCenterWidget()
            ],
          ),
        ),
      )),
    );
  }
}
