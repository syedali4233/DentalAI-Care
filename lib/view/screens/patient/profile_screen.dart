import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/profile_components/profile_screen_components.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/provider/auth_provider.dart';
import 'package:fyp_project/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context).profileData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                10.toHeight,
                Center(
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundImage: const AssetImage(profileImage),
                  ),
                ),
                5.toHeight,
                Center(
                  child: Text(
                    '${profileData['firstname'] ?? ''} ${profileData['lastname'] ?? ''}'
                            .trim()
                            .isNotEmpty
                        ? '${profileData['firstname'] ?? ''} ${profileData['lastname'] ?? ''}'
                        : 'Ruchita',
                    style: maintext,
                  ),
                ),
                10.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          heartbeat,
                          scale: 4.sp,
                        ),
                        Text(
                          'Heart rate',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '215bpm',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: maincolor,
                        width: sqrt1_2,
                        thickness: sqrt1_2,
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          fire,
                          scale: 4.sp,
                        ),
                        Text(
                          'Calories',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '756cal',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: maincolor,
                        width: sqrt1_2,
                        thickness: sqrt1_2,
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          weight,
                          scale: 4.sp,
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '103Ibs',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                30.toHeight,
                const ProfileScreenComponents(
                  title: 'My saved',
                  image: profileHeart,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                const ProfileScreenComponents(
                  title: 'Appointment',
                  image: documnet,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                const ProfileScreenComponents(
                  title: 'Payment Method',
                  image: wallet,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                const ProfileScreenComponents(
                  title: 'FAQS',
                  image: faqsImage,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                ProfileScreenComponents(
                  title: 'Logout',
                  image: logoutIcon,
                  ontap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout(context);
                  },
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
