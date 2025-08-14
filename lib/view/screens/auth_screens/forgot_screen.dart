import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/auth_screens/pin_code_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Forgot Recovery',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(backarrow, scale: 4.0)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.toHeight,
                Text(
                  'Enter your email address and we will send your new password to it.',
                  style: simpletext,
                ),
                20.toHeight,
                TextfieldComponent(
                    width: 350.w,
                    title: 'Enter Your Email',
                    iconimage: prefiximage),
                200.toHeight,
                ButtonComponent(
                    title: 'Send Code',
                    color: maincolor,
                    ontap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PinCodeScreen(),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
