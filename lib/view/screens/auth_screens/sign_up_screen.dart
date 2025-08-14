import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/provider/auth_provider.dart';
import 'package:fyp_project/view/screens/create_account/account_type_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  bool isPasswordVisible = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Sign up',
            style: maintext,
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              backarrow,
              scale: 4.sp,
            ),
          ),
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                25.toHeight,
                Center(
                    child: TextfieldComponent(
                  iconimage: userprofile,
                  title: 'Enter Your Name',
                  controller: nameController,
                  validation: 'Please enter your name',
                )),
                25.toHeight,
                Center(
                    child: TextfieldComponent(
                  iconimage: prefiximage,
                  title: 'Enter Your Email',
                  validation: 'Please enter your email',
                  controller: emailController,
                )),
                25.toHeight,
                TextfieldComponent(
                  title: 'Enter Your Password',
                  validation: 'Please enter your password',
                  controller: passwordController,
                  iconimage: passwordicon,
                  obscureText: isPasswordVisible ? false : true,
                  suffixicon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey)),
                ),
                10.toHeight,
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            child: Container(
                              height: 25.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.sp)),
                            ),
                          ),
                          15.toWidth,
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree to the healthcare ',
                                style: simpletext.copyWith(),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Terms of service',
                                      style: simpletext.copyWith(
                                          color: maincolor)),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style:
                                          simpletext.copyWith(color: maincolor))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 32.w,
                      top: 12.h,
                      child: IgnorePointer(
                        child: Icon(Icons.check_circle_outline,
                            color: isChecked ? maincolor : Colors.transparent,
                            size: 20.sp),
                      ),
                    ),
                  ],
                ),
                200.toHeight,
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return ButtonComponent(
                        title: 'Sign up',
                        color: maincolor,
                        isLoading: value.isLoading,
                        ontap: () {
                          if (_formkey.currentState!.validate()) {
                            if (isChecked) {
                              value.signup(
                                  emailController.text,
                                  passwordController.text,
                                  nameController.text,
                                  context);
                            }
                          }

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const AccountTypeScreen()));
                        });
                  },
                ),
                5.toHeight,
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: simpletext.copyWith(
                        color: Colors.black, fontSize: 14.sp),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                        text: 'Sign In',
                        style: simpletext.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                12.toHeight
              ],
            ),
          ),
        ),
      ),
    );
  }
}
