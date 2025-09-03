import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class DocChangePassword extends StatefulWidget {
  const DocChangePassword({super.key});

  @override
  State<DocChangePassword> createState() => _DocEditScreenState();
}

class _DocEditScreenState extends State<DocChangePassword> {
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController newpassword = TextEditingController();
  TextEditingController currentPassword = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String fullPhoneNumber = "";
  bool isPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).userDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Change Password',
          style: maintext.copyWith(color: Colors.black, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          if (value.userResponse == null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  10.toHeight,
                  Center(
                      child: ShimmerComponents
                          .profilePictureShimmer()), // Profile Picture Shimmer
                  40.toHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerComponents.textFieldShimmer(
                          width: 150), // First Name
                      5.toWidth,
                      ShimmerComponents.textFieldShimmer(
                          width: 150), // Last Name
                    ],
                  ),
                  20.toHeight,
                  ShimmerComponents.textFieldShimmer(width: 320), // Email
                  15.toHeight,
                  ShimmerComponents.textFieldShimmer(width: 320), // Password
                ],
              ),
            );
          }
          final user = value.userResponse!.userInfo;
          return Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.toHeight,
                40.toHeight,
                TextfieldComponent(
                  controller: currentPassword,
                  title: 'Current Password',
                  validation: 'Please enter your password',
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
                20.toHeight,
                TextfieldComponent(
                  controller: newpassword,
                  title: 'New Password',
                  validation: 'Please enter your password',
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
                15.toHeight,
                TextfieldComponent(
                  controller: passwordController,
                  title: 'Confirm Password',
                  validation: 'Please enter your password',
                  //   controller: passwordcontroller,
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
                50.toHeight,
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return ButtonComponent(
                      ontap: () {
                        final data = {
                          'currentPassword': currentPassword.text,
                          'newPassword': newpassword.text,
                          'confirmNewPassword': passwordController.text
                        };
                        print(data);
                        value.changePassword(data, context);
                      },
                      title: 'Change Password',
                      color: maincolor,
                      isLoading: value.isLoading,
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
