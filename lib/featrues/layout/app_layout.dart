import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/featrues/home/ui/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/profile_screen.dart';
import 'package:woodiex/featrues/wishlist/ui/wishlist_screen.dart';
import 'package:woodiex/featrues/notifications/ui/notifications_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[selectedIndex],
        bottomNavigationBar: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedItemColor: ColorsManager.mainBlack,
              unselectedItemColor: Colors.grey,
              onTap: onItemTapped,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/homesvg.svg',
                    colorFilter: ColorFilter.mode(
                      selectedIndex == 0
                          ? ColorsManager.mainBlack
                          : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svgs/whishlist.svg',
                      colorFilter: ColorFilter.mode(
                        selectedIndex == 1
                            ? ColorsManager.mainBlack
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'wishlist'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svgs/notifications.svg',
                      colorFilter: ColorFilter.mode(
                        selectedIndex == 2
                            ? ColorsManager.mainBlack
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'notifications'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svgs/profile.svg',
                      colorFilter: ColorFilter.mode(
                        selectedIndex == 3
                            ? ColorsManager.mainBlack
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'profile'),
              ],
            )));
  }
}
