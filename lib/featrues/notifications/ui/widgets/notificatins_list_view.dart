import 'package:flutter/material.dart';
import 'package:woodiex/featrues/notifications/ui/widgets/notification_list_view_item.dart';

class NotificatinsListView extends StatelessWidget {
  const NotificatinsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust the number of items as needed
      itemBuilder: (context, index) {
        return const NotificationListViewItem(); // Render each item
      },
    );
  }
}
