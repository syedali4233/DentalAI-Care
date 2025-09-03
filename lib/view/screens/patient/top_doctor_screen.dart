import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/home_components/top_doctor_component.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view/screens/patient/doctor_details.dart';
import 'package:fyp_project/view_model/doctors_provider.dart';
import 'package:provider/provider.dart';

class TopDoctorScreen extends StatefulWidget {
  const TopDoctorScreen({super.key});

  @override
  State<TopDoctorScreen> createState() => _TopDoctorScreenState();
}

class _TopDoctorScreenState extends State<TopDoctorScreen> {
  List<Map<dynamic, dynamic>> doctors = [
    {
      'image': 'assets/Image (7).png',
      'title': 'Dr. Rishi',
      'field': 'Chardiologist',
      'rating': '4.7',
      'location': '800'
    },
    {
      'image': 'assets/Image (8).png',
      'title': 'Dr. Vaamana',
      'field': 'Dentists',
      'rating': '4.2',
      'location': '200'
    },
    {
      'image': 'assets/Image (9).png',
      'title': 'Dr. Nallarasi',
      'field': 'Orthopaedic',
      'rating': '4.6',
      'location': '1000'
    },
    {
      'image': 'assets/Image (7).png',
      'title': 'Dr. Rishi',
      'field': 'Chardiologist',
      'rating': '4.7',
      'location': '800'
    },
    {
      'image': 'assets/Image (8).png',
      'title': 'Dr. Vaamana',
      'field': 'Dentists',
      'rating': '4.2',
      'location': '200'
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorsProvider>(context, listen: false).getAlldoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Top Doctors',
          style: maintext,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              5.toHeight,
              Consumer<DoctorsProvider>(
                builder: (context, value, child) {
                  if (value.doctorResponse == null) {
                    return ShimmerComponents.cardShimmer();
                  }

                  final doct = value.doctorResponse!.doctors;
                  if (doct.isEmpty) {
                    return const Center(child: Text('No doctors found'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: doct.length,
                    itemBuilder: (context, index) {
                      final doctor = doct[index]; // ✅ Corrected here

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: TopDoctorComponent(
                          ontapp: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetails(
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
                          rating:
                              "4.5", // example, add real rating if available
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
        ),
      ),
    );
  }
}
