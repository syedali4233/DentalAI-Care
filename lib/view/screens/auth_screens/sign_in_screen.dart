import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/components/auth_components/textfield_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view/screens/create_account/account_type_screen.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:fyp_project/view/screens/auth_screens/forgot_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Sign In',
          style: maintext,
        ),
        // leading: Image.asset(
        //   backarrow,
        //   scale: 4.sp,
        // ),
        // title: Row(
        //   children: [
        //     Image.asset(
        //       backarrow,
        //       scale: 4.sp,
        //     ),
        //     100.toWidth,
        //     Text(
        //       'Sign In',
        //       style: maintext,
        //     )
        //   ],
        // ),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.toHeight,
              50.toHeight,
              Center(
                  child: TextfieldComponent(
                iconimage: prefiximage,
                title: 'Enter Your Email',
                validation: 'enter your Email',
                controller: emailcontroller,
              )),
              25.toHeight,
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
              50.toHeight,
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return ButtonComponent(
                      title: 'Sign In',
                      color: maincolor,
                      isLoading: value.isLoading,
                      ontap: () {
                        if (_formkey.currentState!.validate()) {
                          final data = {
                            'email': emailcontroller.text,
                            'password': passwordcontroller.text
                          };
                          value.loginApis(data, context);
                        }
                      });
                },
              ),
              8.toHeight,
              RichText(
                text: TextSpan(
                  text: "Don't have an account?  ", // First part
                  style: simpletext.copyWith(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AccountTypeScreen(), // Replace with your actual screen
                            ),
                          );
                        },
                      text: 'Sign up',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
              25.toHeight,
            ],
          ),
        ),
      ),
    );
  }
}
