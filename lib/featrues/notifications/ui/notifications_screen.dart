import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/notifications/ui/widgets/notifications_top_bar.dart';
import 'package:woodiex/featrues/notifications/ui/widgets/notificatins_list_view.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              NotificationsTopBar(),
              verticalSpace(20),
              Expanded(child: NotificatinsListView())
            ],
          ),
        )),
      ),
    );
  }
}
