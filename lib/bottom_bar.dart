import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/doctor_side/doc_chat_screen.dart';
import 'package:fyp_project/view/screens/patient/Notification_screen.dart';
import 'package:fyp_project/view/screens/patient/Reports_screen.dart';

import 'package:fyp_project/view/screens/patient/detecion_screen.dart';
import 'package:fyp_project/view/screens/patient/home_screen.dart';
import 'package:fyp_project/view/screens/patient/profile_screen.dart';
import '../../constants/colors.dart';

class patientBottombar extends StatefulWidget {
  final int? index;
  const patientBottombar({super.key, this.index});

  @override
  State<patientBottombar> createState() => _patientBottombarState();
}

class _patientBottombarState extends State<patientBottombar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0; // default to 0 if null
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const DocChatScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 0) {
      return true;
    } else {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: _screens[_selectedIndex],
        ),

        // Floating Plus Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DetecionScreen()),
            );
          },
          backgroundColor: maincolor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // ✅ Bottom NavigationBar must be inside Scaffold
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          color: maincolor.withOpacity(0.2),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: maincolor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconSize: 22, // reduce icon size if needed
            selectedLabelStyle: simpletext.copyWith(
              fontWeight: FontWeight.w600,
              color: maincolor,
              fontSize: 12.sp,
            ),
            unselectedLabelStyle: simpletext.copyWith(fontSize: 11.sp),
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/Home.png',
                  scale: 4.sp,
                  color: _selectedIndex == 0 ? maincolor : Colors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/Frame 5 (1).png',
                  scale: 4.sp,
                  color: _selectedIndex == 1 ? maincolor : Colors.black,
                ),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  chatIcon,
                  scale: 4.sp,
                  color: _selectedIndex == 2 ? maincolor : Colors.black,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/Profile.png',
                  scale: 4.sp,
                  color: _selectedIndex == 3 ? maincolor : Colors.black,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
