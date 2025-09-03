import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/bottom_bar.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/onboarding_screen.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/view/screens/doctor_side/doctor_bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      // final userId =
      //     await SharedPreferencesManager.getUserIdFromSharedPreferences();
      // //   final accountType = await SharedPreferencesManager.getAccountType();

      // if (!mounted) return;

      // if (userId == null) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      //   );
      // } else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (_) => DoctorpatientBottombar(index: 0)),
      //   );
      // }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Screenshot 2025-08-28 115233.png',
              scale: 2.sp,
            ),
            10.toHeight,
            Center(
              child: Image.asset(
                'assets/Group 43 (1).png',
                scale: 4.sp,
              ),
            )
          ],
        ));
  }
}
