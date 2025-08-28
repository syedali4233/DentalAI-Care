import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/splash_screen.dart';

import 'package:fyp_project/view/screens/doctor_side/doc_change_password.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:fyp_project/firebase_options.dart';
import 'package:fyp_project/view_model/doctors_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';

import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      // const ResponsiveDebugger(
      //   enabled: kDebugMode, // Only enable in debug mode
      //   child: MyApp(),
      // ),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => ProfileProvider()),
              ChangeNotifierProvider(create: (_) => DoctorsProvider())
            ],
            child: MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: SplashScreen())));
  }
}
