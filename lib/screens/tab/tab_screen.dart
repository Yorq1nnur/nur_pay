import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/screens/tab/card/card_screen.dart';
import 'package:nur_pay/screens/tab/history/history_screen.dart';
import 'package:nur_pay/screens/tab/home/home_screen.dart';
import 'package:nur_pay/screens/tab/profile/profile_screen.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/images/app_images.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    super.key,
  });

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = const [
    HomeScreen(),
    HistoryScreen(),
    CardScreen(),
    ProfileScreen(),
  ];

  int activeIndex = 0;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: AppColors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: activeIndex,
        onTap: (newIndex) {
          activeIndex = newIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.home,
              height: 30.h,
              width: 30.w,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.home,
              height: 30.h,
              width: 30.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.history,
              height: 24.h,
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.history,
              height: 24.h,
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.card,
              height: 24.h,
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.card,
              height: 24.h,
              width: 24.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Cards",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.profile,
              height: 30.h,
              width: 30.w,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              AppImages.profile,
              height: 30.h,
              width: 30.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
