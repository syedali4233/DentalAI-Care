import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/home_components/top_doctor_component.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/patient/doctor_details.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                      'Top Doctors',
                      style: maintext,
                    )
                  ],
                ),
              ),
              20.toHeight,
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TopDoctorComponent(
                          ontapp: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DoctorDetails()));
                          },
                          imagee: doctor['image'],
                          title: doctor['title'],
                          field: doctor['field'],
                          rating: doctor['rating'],
                          locations: doctor['location']),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
