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
import 'package:fyp_project/provider/profile_provider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // You can fetch initial data here if needed
      Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileProvider>(context).profileData;
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
                  Text(
                    'Dr. ${profileData['firstname'] ?? ''} ${profileData['lastname'] ?? 'loading...'}',
                    style: maintext.copyWith(fontSize: 14.sp),
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
                        ListView.builder(
                            shrinkWrap: true, // <— very important
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: appoints.length,
                            itemBuilder: (context, index) {
                              final articleview = appoints[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: AppointmentsComponents(
                                  title: articleview['title'],
                                  date: articleview['readtime'],
                                  read: articleview['date'],
                                  imagee: articleview['image'],
                                  onclicked: istap,
                                ),
                              );
                            })
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
