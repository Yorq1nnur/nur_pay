import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/screens/tab/card/card_screen.dart';
import 'package:nur_pay/screens/tab/history/history_screen.dart';
import 'package:nur_pay/screens/tab/home/home_screen.dart';
import 'package:nur_pay/screens/tab/profile/profile_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (newIndex) {
          activeIndex = newIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
              color: Colors.black,
              size: 20.w,
            ),
            label: "Categories",
            activeIcon: Icon(
              Icons.category,
              color: Colors.blue,
              size: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              color: Colors.black,
              size: 20.w,
            ),
            label: "Books",
            activeIcon: Icon(
              Icons.book,
              color: Colors.blue,
              size: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 20.w,
            ),
            label: "Settings",
            activeIcon: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 30.w,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
              size: 20.w,
            ),
            label: "Settings",
            activeIcon: Icon(
              Icons.settings,
              color: Colors.blue,
              size: 30.w,
            ),
          ),
        ],
      ),
    );
  }
}
