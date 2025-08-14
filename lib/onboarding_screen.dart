import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/splash_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingModel {
  final String url;
  final String title;
  final String description;

  OnBoardingModel({
    required this.url,
    required this.title,
    required this.description,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<OnBoardingModel> onBoardingArray = [
    OnBoardingModel(
      url:
          'assets/beautiful-young-female-doctor-looking-camera-office-removebg-preview 1.png',
      title: 'Where Healing Begins\nFor Patients and\nProfessionals Alike',
      description: 'Where Healing Begins For Patients and Professionals Alike',
    ),
    OnBoardingModel(
      url:
          'assets/doctor-with-his-arms-crossed-white-background-removebg-preview 1.png',
      title: 'Get advice only from a doctor\nyou believe in.',
      description:
          'Track inventory and auto-create shopping lists to save budget.',
    ),
    OnBoardingModel(
      url: applogo,
      title: '',
      description:
          'Chat with AI for quick meal ideas and easier, stress-free cooking.',
    ),
  ];

  Widget buildIndicator(int index, int currentIndex) {
    bool isActive = index == currentIndex;
    bool isNext = index > currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      height: 12.h,
      width: isActive ? 18.w : 12.w,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xff407CE2) // current
            : isNext
                ? Colors.transparent // next – no fill
                : const Color(0xff407CE2).withOpacity(0.6), // previous
        border: isNext
            ? Border.all(
                color: const Color(0xff407CE2).withOpacity(0.6), width: 2)
            : null,
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onBoardingArray.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Mascot image
                    if (index == onBoardingArray.length - 1)
                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        right: 10.w,
                        child: Column(
                          children: [
                            SizedBox(height: 190.h),
                            Center(
                              child: Image.asset(
                                applogo,
                                scale: 4.5.sp,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Let’s get started!',
                              style: maintext,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Login to Stay healthy and fit ',
                              style: simpletext,
                            ),
                            SizedBox(height: 42.h),
                            ButtonComponent(
                              title: 'Login',
                              color: maincolor,
                              height: 56.h,
                              width: 250.w,
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignInScreen()));
                              },
                            ),
                            SizedBox(height: 16.h),
                            ButtonComponent(
                              title: 'Sign Up',
                              textColor: maincolor,
                              color: Colors.white,
                              height: 56.h,
                              width: 250.w,
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                              },
                            )
                          ],
                        ),
                      )
                    else
                      Positioned(
                        bottom: 190.h,
                        left: 10.w,
                        right: 10.w,
                        child: Center(
                          child: Image.asset(
                            onBoardingArray[index].url,
                            scale: 4.5.sp,
                          ),
                        ),
                      ),
                    // Bottom card
                    if (index == onBoardingArray.length - 1)
                      SizedBox()
                    else
                      Positioned(
                        bottom: 0.h,
                        child: Container(
                          height: 190.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              if (index == onBoardingArray.length - 1)
                                SizedBox(height: 10.h)
                              else
                                SizedBox(
                                  height: 20.h,
                                ),
                              Text(
                                onBoardingArray[index].title,
                                textAlign: TextAlign.center,
                                style: maintext,
                              ),
                              SizedBox(height: 30.h),
                              if (index == onBoardingArray.length - 1)
                                SizedBox()
                              else
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: List.generate(
                                          onBoardingArray.length,
                                          (index) => buildIndicator(
                                              index, currentIndex),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             OnBoardingScreen()));
                                          if (currentIndex <
                                              onBoardingArray.length - 1) {
                                            _controller.nextPage(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: const BoxDecoration(
                                              color: Color(0xff407CE2),
                                              shape: BoxShape.circle),
                                          child: Image.asset(
                                            forwardarrow,
                                            scale: 4,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
