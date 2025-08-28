import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view_model/doctors_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DoctorDetails extends StatefulWidget {
  final String id;
  const DoctorDetails({super.key, required this.id});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  final List<DateTime> next14Days = List.generate(
    14,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  int selectedIndex = 0;
  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '07:00 PM',
    '08:00 PM',
  ];
  int selectedTimeIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DoctorsProvider>(context, listen: false)
        .getSpecificDoc(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.toHeight,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back)),
                      70.toWidth,
                      Text(
                        'Doctors Detail',
                        style: maintext,
                      )
                    ],
                  ),
                ),
                20.toHeight,
                Consumer<DoctorsProvider>(
                  builder: (context, value, child) {
                    if (value.specificDoctor == null) {
                      return ShimmerComponents.cardShimmer();
                    }
                    final doctor = value.specificDoctor!.doctor;
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      height: 120.h,
                      width: 330.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/Image (7).png'),
                                      fit: BoxFit.fill),
                                  color: Colors.white),
                            ),
                            20.toWidth,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                5.toHeight,
                                Text(
                                  'Dr. ${doctor.firstName} ${doctor.lastName}',
                                  style: maintext.copyWith(fontSize: 16.sp),
                                ),
                                5.toHeight,
                                Text(
                                  doctor.email,
                                  style: simpletext.copyWith(fontSize: 10.sp),
                                ),
                                8.toHeight,
                                Container(
                                  height: 20.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      // ignore: deprecated_member_use
                                      color: maincolor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        starRating,
                                        scale: 4.sp,
                                      ),
                                      Text(
                                        '4.7',
                                        style: simpletext.copyWith(
                                            color: maincolor, fontSize: 12.sp),
                                      )
                                    ],
                                  ),
                                ),
                                8.toHeight,
                                Row(
                                  children: [
                                    Image.asset(
                                      locationImage,
                                      scale: 4.sp,
                                    ),
                                    5.toWidth,
                                    Text(
                                      '800m away',
                                      style:
                                          simpletext.copyWith(fontSize: 12.sp),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                10.toHeight,
                Text(
                  'About',
                  style: maintext.copyWith(fontSize: 16.sp),
                ),
                Consumer<DoctorsProvider>(
                  builder: (context, value, child) {
                    if (value.specificDoctor == null) {
                      return ShimmerComponents.textShimmer();
                    }
                    final doctor = value.specificDoctor!.doctor;
                    return ReadMoreText(
                      doctor.bio,
                      style: simpletext,
                      trimLines: 3,
                      textAlign: TextAlign.justify,
                      moreStyle: simpletext.copyWith(color: maincolor),
                      lessStyle: simpletext.copyWith(color: maincolor),
                    );
                  },
                ),
                10.toHeight,
                SizedBox(
                  height: 70.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: next14Days.length,
                    itemBuilder: (context, index) {
                      final date = next14Days[index];
                      final day = _getDayOfWeek(date);
                      final dayNum = date.day.toString();
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10.w),
                          height: 60.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: isSelected ? maincolor : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day,
                                style: simpletext.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              5.toHeight,
                              Text(
                                dayNum,
                                style: maintext.copyWith(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                    // width: sqrt1_2,
                    thickness: sqrt1_2,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: timeSlots.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = selectedTimeIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? maincolor : Colors.white,
                          border: Border.all(color: maincolor),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            timeSlots[index],
                            style: maintext.copyWith(
                              color: isSelected ? Colors.white : maincolor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                30.toHeight,
                Consumer<DoctorsProvider>(
                  builder: (context, value, child) {
                    return Center(
                      child: ButtonComponent(
                          title: 'Book Appointment',
                          isLoading: value.isLoading,
                          color: maincolor,
                          ontap: () {
                            final selectedDate = next14Days[selectedIndex];
                            final formattedDate =
                                "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

                            // Convert selected time to 24-hour format
                            final selectedTime =
                                _formatTimeTo24(timeSlots[selectedTimeIndex]);

                            final data = {
                              'date': formattedDate,
                              'time': selectedTime
                            };
                            print(data);
                            value.bookAppointment(data, widget.id);
                          }),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    // Returns short day name, e.g., Mon, Tue, etc.
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

  String _formatTimeTo24(String time) {
    // Split into hours, minutes and period (AM/PM)
    final parts = time.split(' ');
    final hm = parts[0].split(':');
    int hour = int.parse(hm[0]);
    final minute = hm[1];
    final period = parts[1]; // AM or PM

    // Convert to 24-hour format
    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    // Return formatted string like 14:00
    return "${hour.toString().padLeft(2, '0')}:$minute";
  }
}
