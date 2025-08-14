import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/home_components/article.dart';
import 'package:fyp_project/components/patient/reports_component/heartrate_component.dart';
import 'package:fyp_project/components/patient/reports_component/report_card.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.toHeight,
                const Center(
                    child: HeartrateComponent(
                  bpmm: '97',
                )),
                10.toHeight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReportCard(
                      title: 'Blood Group',
                      subtitile: 'A +',
                      image: bloodGroup,
                      backgroundcolor: Color(0xffB2748C),
                    ),
                    ReportCard(
                      title: 'Weight',
                      image: liftWeighting,
                      subtitile: '103lbs',
                      borderColor: Color(0xffFBF0DC),
                      backgroundcolor: Color(0xffFBF0DC),
                    )
                  ],
                ),
                14.toHeight,
                Text(
                  'Latest report',
                  style: maintext.copyWith(fontSize: 16.sp),
                ),
                10.toHeight,
                const Article(
                    title: 'General Report',
                    date: 'jul 10,',
                    read: '2023',
                    imagee: bloodGroup),
                10.toHeight,
                const Article(
                    title: 'General Report',
                    date: 'jul 10,',
                    read: '2023',
                    imagee: bloodGroup)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
