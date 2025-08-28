import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/home_components/article.dart';
import 'package:fyp_project/components/patient/home_components/search_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view/screens/patient/top_doctor_screen.dart';
import 'package:fyp_project/view_model/profile_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<dynamic, dynamic>> articles = [
    {
      'image': 'assets/Rectangle 460.png',
      'title':
          'The 25 Healthiest Fruits You Can\n Eat, According to a Nutritionist',
      'date': 'Jun 10,2023',
      'readtime': '5mint read'
    },
    {
      'image': 'assets/Rectangle 954.png',
      'title': 'The Impact of COVID-19 on\n Healthcare Systems',
      'date': 'july 10,2024',
      'readtime': '10mint read'
    },
    {
      'image': 'assets/Rectangle 954.png',
      'title': 'The Impact of COVID-19 on\n Healthcare Systems',
      'date': 'july 10,2024',
      'readtime': '10mint read'
    }
  ];
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
              top: 20.h,
              right: 5.w,
              child: Image.asset(
                femaleDoctorr,
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
                        user.fullName,
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
              bottom: 0,
              left: 0,
              right: 0,
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
                        const SearchComponent(
                          hintText: 'Search Doctors,Nurses',
                        ),
                        20.toHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TopDoctorScreen()));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: maincolor,
                                    radius: 30.sp,
                                    child: Transform.scale(
                                      scale: 0.7
                                          .sp, // Scale image inside circle (0.0 to 1.0)
                                      child: Image.asset(
                                        doctorLogo,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                3.toHeight,
                                const Text('Top Nurses')
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: maincolor,
                                  radius: 30.sp,
                                  child: Transform.scale(
                                    scale:
                                        0.6, // Scale image inside circle (0.0 to 1.0)
                                    child: Image.asset(
                                      ambulanaceLogo,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                3.toHeight,
                                const Text('Ambulanace')
                              ],
                            )
                          ],
                        ),
                        20.toHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Health article',
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
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              final articleview = articles[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Article(
                                    title: articleview['title'],
                                    date: articleview['date'],
                                    read: articleview['readtime'],
                                    imagee: articleview['image']),
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
