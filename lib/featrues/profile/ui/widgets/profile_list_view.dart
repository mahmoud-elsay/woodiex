import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/featrues/profile/ui/widgets/profile_list_view_item.dart';


class ProfileListView extends StatelessWidget {
  const ProfileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, // Ensures the ListView does not expand infinitely
      physics: NeverScrollableScrollPhysics(), // Disable scrolling
      children: [
        ProfileListViewItem(
          title: 'My Orders',
          subtitle: 'Already have 10 orders',
          onTap: () {
            context.pushNamed(Routes.myOrders);
          },
        ),
        ProfileListViewItem(
          title: 'Payment Methods',
          subtitle: 'Manage your payment options',
          onTap: () {
            context.pushNamed(Routes.paymentMethods);
          },
        ),
        ProfileListViewItem(
          title: 'Shipping Address',
          subtitle: 'Manage your shipping addresses',
          onTap: () {
            context.pushNamed(Routes.shippingAddreesScreen);
          },
        ),
        ProfileListViewItem(
          title: 'My Reviews',
          subtitle: 'See your reviews',
          onTap: () {
            context.pushNamed(Routes.myReviewsScreen);
          },
        ),
        ProfileListViewItem(
          title: 'Settings',
          subtitle: 'Change your settings',
          onTap: () {
            context.pushNamed(Routes.setteing);
          },
        ),
      ],
    );
  }
}
