import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_up_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Reset Password',
          style: maintext,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.toHeight,
              Text('Enter a new password for your account', style: simpletext),
              50.toHeight,
              Text(
                'Password',
                style: maintext.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
              5.toHeight,
              const TextfieldComponent(
                  title: 'Enter Password', iconimage: passwordicon),
              10.toHeight,
              Text(
                'Confirm Password',
                style: maintext.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w300),
                textAlign: TextAlign.start,
              ),
              5.toHeight,
              const TextfieldComponent(
                  title: 'Confirm Password', iconimage: passwordicon),
              200.toHeight,
              Center(
                child: ButtonComponent(
                    title: 'Save',
                    color: maincolor,
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
