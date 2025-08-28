import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/create_account/create_account_screen.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountTypeScreen> {
  String _selectedOption = 'option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 350.h,
                width: double.infinity,
                color: maincolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    50.toHeight,
                    Text(
                      'Account Type',
                      style: maintext.copyWith(color: Colors.white),
                    ),
                    10.toHeight,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Select one of the profiles below according to your usability.',
                        style: simpletext.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Use Spacer to push content to center vertically
              const Spacer(),

              /// ✅ Centered Radio Options

              const Spacer(),

              ButtonComponent(
                  title: 'Next',
                  color: maincolor,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountScreen(
                                  data: {
                                    'role': _selectedOption,
                                  },
                                )));
                    print('$_selectedOption');
                  }),

              20.toHeight,
            ],
          ),
          Positioned(
            top: 300.h,
            left: 65.w,
            child: Container(
              height: 100.h,
              width: 230.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'patient',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('I am a Patient', style: simpletext),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'nurse',
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value!;
                          });
                        },
                      ),
                      Text('I am a Nurse', style: simpletext),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
