import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/home_components/search_component.dart';
import 'package:fyp_project/components/patient/home_components/top_doctor_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view/screens/patient/doctor_details.dart';
import 'package:fyp_project/view/screens/patient/top_doctor_screen.dart';
import 'package:fyp_project/view_model/doctors_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  List<Map<dynamic, dynamic>> articles = [
    {
      'image': maledoctor,
      'title': 'Zeeshan Khan',
      'date': 'Dentist',
      'readtime': '5mint read'
    },
    {
      'image': femalePatient2,
      'title': 'Bilal Khan',
      'date': 'Dentist',
      'readtime': '10mint read'
    },
    {
      'image': femalePatient,
      'title': 'Mudasir Khan',
      'date': 'Dentist',
      'readtime': '10mint read'
    }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).userDetails();
      Provider.of<DoctorsProvider>(context, listen: false).getAlldoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            // Positioned(
            //   top: 20.h,
            //   right: 5.w,
            //   child: Image.asset(
            //     femaleDoctorr,
            //     scale: 4.sp,
            //   ),
            // ),
            Positioned(
              top: 120.h,
              left: 30.w,
              child: SizedBox(
                width: 290.w,
                child: SearchComponent(
                  hintText: 'Search Doctors',
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _query = value.trim().toLowerCase();
                    });
                  },
                ),
              ),
            ),
            // Welcome content on top left
            Positioned(
              top: 60.h,
              left: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          if (value.userResponse == null) {
                            return ShimmerComponents.profilePictureShimmer();
                          }
                          final user = value.userResponse!.userInfo;
                          return CircleAvatar(
                            radius: 30.sp,
                            backgroundColor: maincolor,
                            backgroundImage: (user.profileImage != null &&
                                    user.profileImage.isNotEmpty)
                                ? NetworkImage(user.profileImage)
                                : const AssetImage(maledoctor) as ImageProvider,
                          );
                        },
                      ),
                      10.toWidth,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello Welcome !',
                            style: simpletext.copyWith(
                                color: Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w100),
                          ),
                          Consumer<ProfileProvider>(
                            builder: (context, value, child) {
                              if (value.userResponse == null) {
                                return ShimmerComponents.textShimmer();
                              }
                              final user = value.userResponse!.userInfo;
                              return Text(
                                user.fullName,
                                style: maintext.copyWith(fontSize: 14.sp),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 400.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(30.r),
                    //   topRight: Radius.circular(30.r),
                    // ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            20.toHeight,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Top Doctors',
                                  style: maintext.copyWith(fontSize: 16.sp),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TopDoctorScreen()));
                                  },
                                  child: Text(
                                    'See all',
                                    style:
                                        simpletext.copyWith(color: maincolor),
                                  ),
                                )
                              ],
                            ),
                            10.toHeight,
                            Consumer<DoctorsProvider>(
                              builder: (context, value, child) {
                                if (value.doctorResponse == null) {
                                  return ShimmerComponents.cardShimmer();
                                }

                                final doct = value.doctorResponse!.doctors;
                                if (doct.isEmpty) {
                                  return const Center(
                                      child: Text('No doctors found'));
                                }

                                final list = doct.where((d) {
                                  if (_query.isEmpty) return true;
                                  final fullName =
                                      '${d.firstName ?? ''} ${d.lastName ?? ''}'
                                          .toLowerCase();
                                  final email = (d.email ?? '').toLowerCase();
                                  return fullName.contains(_query) ||
                                      email.contains(_query);
                                }).toList();

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: list.length > 4 ? 4 : list.length,
                                  itemBuilder: (context, index) {
                                    final doctor = list[index];

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: TopDoctorComponent(
                                        ontapp: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorDetails(
                                                id: doctor.id,
                                              ),
                                            ),
                                          );
                                        },
                                        imagee: doctor.profileImage ??
                                            maledoctor, // ✅ Object property
                                        title:
                                            "Dr. ${doctor.firstName ?? ''} ${doctor.lastName ?? ''}",
                                        field: doctor.email ?? 'N/A',
                                        // rating:
                                        //     "4.5", // example, add real rating if available
                                        locations:
                                            "isb", // example, add real location if available
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
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
