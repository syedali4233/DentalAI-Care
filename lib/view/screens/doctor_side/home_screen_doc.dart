import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/doctor_side_components/appointments_components.dart';
import 'package:fyp_project/components/patient/home_components/article.dart';
import 'package:fyp_project/components/patient/home_components/search_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view_model/doctors_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';
import 'package:fyp_project/view/screens/patient/top_doctor_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenDoc extends StatefulWidget {
  const HomeScreenDoc({super.key});

  @override
  State<HomeScreenDoc> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenDoc> {
  List<Map<dynamic, dynamic>> appoints = [
    {
      'title': 'Ruchita',
      'date': '23 JAN 2025',
      'readtime': '10:00 AM',
      'image': femalePatient,
    },
    {
      'title': 'Sarah',
      'date': '24 JAN 2025',
      'readtime': '11:00 AM',
      'image': femalePatient2,
    },
    {
      'title': 'Ruchita',
      'date': '23 JAN 2025',
      'readtime': '10:00 AM',
      'image': femalePatient,
    },
    {
      'title': 'Mia',
      'date': '24 JAN 2025',
      'readtime': '11:00 AM',
      'image': femalePatient2,
    },
    // Add more appointments as needed
  ];

  bool istap = false;

  void toggleTap() {
    setState(() {
      istap = !istap;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(
    //           'Edit Profile',
    //           style: maintext,
    //         ),
    //         content: Text(
    //           'Please complete your profile',
    //           style: simpletext,
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(),
    //             child: const Text('okay'),
    //           ),
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(),
    //             child: const Text('Close'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).userDetails();
      Provider.of<DoctorsProvider>(context, listen: false).getAppointmentfuc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background Banner
            Positioned.fill(
              child: Image.asset(
                bannerr,
                fit: BoxFit.cover,
              ),
            ),

            // Female doctor on top right
            Positioned(
              top: 45.h,
              right: 10.w,
              child: Image.asset(
                telescopePills,
                scale: 4.sp,
              ),
            ),

            // Welcome content on top left
            Positioned(
              top: 60.h,
              left: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.sp,
                    backgroundColor: maincolor,
                    backgroundImage: const AssetImage(maledoctor),
                  ),
                  20.toHeight,
                  Text(
                    'Welcome !',
                    style: maintext.copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.w300),
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      if (value.userResponse == null) {
                        return ShimmerComponents.textShimmer();
                      }
                      final user = value.userResponse!.userInfo;
                      return Text(
                        'Dr. ${user.fullName}',
                        style: maintext.copyWith(fontSize: 14.sp),
                      );
                    },
                  ),
                  20.toHeight,
                  Text(
                    'How is it going today?',
                    style: simpletext,
                  )
                ],
              ),
            ),

            // ✅ Bottom container
            Positioned(
              bottom: 0.h,
              left: 0.w,
              right: 0.h,
              child: Container(
                  height: 380.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: toggleTap,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        istap ? Colors.grey : maincolor,
                                    radius: 30.sp,
                                    child: Transform.scale(
                                      scale: 0.5
                                          .sp, // Scale image inside circle (0.0 to 1.0)
                                      child: Image.asset(
                                        waitingAppointment,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                3.toHeight,
                                const Text('Today'),
                                const Text('Appointments'),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: toggleTap,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        istap ? maincolor : Colors.grey,
                                    radius: 30.sp,
                                    child: Transform.scale(
                                      scale:
                                          0.5, // Scale image inside circle (0.0 to 1.0)
                                      child: Image.asset(
                                        appointsRequest,
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                3.toHeight,
                                const Text('Appointment'),
                                const Text('Requests')
                              ],
                            ),
                          ],
                        ),
                        20.toHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              istap ? 'Requests' : 'Appointments',
                              style: maintext.copyWith(fontSize: 16.sp),
                            ),
                            Text(
                              'See all',
                              style: simpletext.copyWith(color: maincolor),
                            )
                          ],
                        ),
                        Consumer<DoctorsProvider>(
                          builder: (context, value, child) {
                            if (value.appointments == null) {
                              return ShimmerComponents.cardShimmer();
                            }
                            final appoint = value.appointments!.appointments;
                            print(appoint);
                            return ListView.builder(
                                shrinkWrap: true, // <— very important
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: appoint.length,
                                itemBuilder: (context, index) {
                                  final appointm =
                                      value.appointments!.appointments[index];
                                  final articleview = appoints[index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: AppointmentsComponents(
                                      title:
                                          "${appointm.patient.firstName} ${appointm.patient.lastName}",
                                      date: appointm.time,
                                      read: appointm.date.toString(),
                                      imagee: articleview['image'],
                                      onclicked: istap,
                                    ),
                                  );
                                });
                          },
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
