import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/bottom_bar.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/provider/auth_provider.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/patient/home_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  final Map<String, dynamic>? data;
  const CreateAccountScreen({super.key, this.data});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isPasswordVisible = false;
  TextEditingController passwordcontroller = TextEditingController();
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('Data from previous screen: ${widget.data}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 350.h,
                  width: double.infinity,
                  color: maincolor,
                  child: Column(
                    children: [
                      50.toHeight,
                      Text(
                        'Create Account',
                        style: maintext.copyWith(color: Colors.white),
                      ),
                      10.toHeight,
                      RichText(
                        text: TextSpan(
                            text: 'Already have an Account? ',
                            style: simpletext.copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInScreen()));
                                    },
                                  text: 'Log in',
                                  style:
                                      simpletext.copyWith(color: Colors.white))
                            ]),
                      )
                    ],
                  ),
                ),
                200.toHeight,
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return ButtonComponent(
                        title: 'Continue',
                        color: maincolor,
                        isLoading: value.isLoading,
                        ontap: () {
                          if (_formkey.currentState!.validate()) {
                            value.createaccount(
                                firstname.text,
                                lastname.text,
                                emailController.text,
                                passwordcontroller.text,
                                phoneController.text,
                                widget.data?['accountType'] ?? '',
                                context);
                          }
                        });
                  },
                )
              ],
            ),
            Positioned(
              top: 180.h,
              left: 15.w,
              child: Container(
                //  height: 300.h,
                width: 330.w,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    20.toHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextfieldComponent(
                          width: 150,
                          title: 'First Name',
                          controller: firstname,
                          validation: 'Please enter your first name',
                        ),
                        5.toWidth,
                        TextfieldComponent(
                          width: 150,
                          title: 'Last Name',
                          controller: lastname,
                          validation: 'Please enter your last name',
                        ),
                      ],
                    ),
                    15.toHeight,
                    TextfieldComponent(
                      title: 'Enter your Email',
                      controller: emailController,
                      validation: 'Please enter your email',
                      iconimage: prefiximage,
                    ),
                    15.toHeight,
                    TextfieldComponent(
                      title: 'Enter Your Password',
                      validation: 'Please enter your password',
                      controller: passwordcontroller,
                      iconimage: passwordicon,
                      obscureText: isPasswordVisible ? false : true,
                      suffixicon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey)),
                    ),
                    15.toHeight,
                    SizedBox(
                      width: 300.w,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: phoneController,
                        formatInput: true,
                        keyboardType: TextInputType.phone,
                        inputDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white, // White background
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 10.w), // Reduce height
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                    20.toHeight
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
