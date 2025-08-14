import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/bottom_bar.dart';
import 'package:fyp_project/onboarding_screen.dart';
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
      final user = FirebaseAuth.instance.currentUser;

      // If user is not logged in → go to onboarding
      if (user == null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
        );
        return;
      }

      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!mounted) return;

        if (snapshot.exists) {
          final accountType = snapshot.data()?['accountType'];

          if (accountType == 'Patient') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => patientBottombar(index: 0)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DoctorpatientBottombar(index: 0)),
            );
          }
        } else {
          // If user doc doesn't exist, go to onboarding
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
          );
        }
      } catch (e) {
        print('Error fetching account type: $e');
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff98B3E1).withOpacity(0.9),
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/Group 11.png',
                    scale: 4,
                  ),
                ),
              ),
              const SizedBox(
                height: 300,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    'assets/Group 47.png',
                    scale: 6,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/Group 58.png',
                  scale: 4,
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/Group 142.png',
                scale: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
