import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/auth_screens/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose(); // ✅ Dispose properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Password Recovery',
          style: maintext,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Please enter the 6-digit verification code we sent to: test@gmail.com',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(height: 50.h),
                PinCodeTextField(
                  controller: _pinController,
                  appContext: context,
                  length: 6,
                  enableActiveFill: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter a valid 6-digit PIN';
                    }
                    return null;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15.r),
                    fieldHeight: 40.h,
                    fieldWidth: 40.w,
                    activeColor: Colors.black,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 300.h),
                ButtonComponent(
                  title: 'Submit',
                  color: maincolor,
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      print('Entered PIN: ${_pinController.text}');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()));
                    } else {
                      print('Invalid PIN');
                    }
                  },
                ),
                5.toHeight,
                Text.rich(TextSpan(
                  text: 'Didn\'t receive the code? ',
                  style: simpletext,
                  children: [
                    TextSpan(
                      text: 'Resend',
                      style: const TextStyle(
                        color: maincolor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle resend code action
                          print('Resend code tapped');
                        },
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
