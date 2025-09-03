import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/doctor_side/doc_chat_screen.dart';
import 'package:fyp_project/view/screens/doctor_side/doc_profile_screen.dart';
import 'package:fyp_project/view/screens/doctor_side/home_screen_doc.dart';
import 'package:fyp_project/view/screens/patient/Notification_screen.dart';
import 'package:fyp_project/view/screens/patient/Reports_screen.dart';
import 'package:fyp_project/view/screens/patient/home_screen.dart';
import 'package:fyp_project/view/screens/patient/profile_screen.dart';

class DoctorpatientBottombar extends StatefulWidget {
  DoctorpatientBottombar({
    super.key,
    this.index,
  });
  int? index;
  @override
  State<DoctorpatientBottombar> createState() => _patientBottombarState();
}

class _patientBottombarState extends State<DoctorpatientBottombar> {
  int _selectedIndex = 0; // Tracks the selected index

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = widget.index!;
    super.initState();
  }

  // List of screens for each tab
  final List<Widget> _screens = [
    //  HomeScreen(),
    const HomeScreenDoc(),
    DocChatScreen(),
    const DocProfileScreen(),
  ];

  // Function to handle item tap
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
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 0), // Adjust shadow direction
              ),
            ],
          ),
          height: 68.h,
          child: ClipRRect(
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: maincolor,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: simpletext.copyWith(
                  fontWeight: FontWeight.w600, color: maincolor),
              unselectedLabelStyle: simpletext,
              showUnselectedLabels: true,
              backgroundColor: Colors.white,
              elevation: 0, // Elevation moved to container
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/Home.png',
                    scale: 4.sp,
                    color: _selectedIndex == 0 ? maincolor : Colors.grey,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    chatIcon,
                    scale: 4.sp,
                    color: _selectedIndex == 1 ? maincolor : Colors.grey,
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/Profile.png',
                    scale: 4.sp,
                    color: _selectedIndex == 2 ? maincolor : Colors.grey,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
