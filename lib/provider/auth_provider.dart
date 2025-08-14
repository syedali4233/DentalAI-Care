import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/bottom_bar.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/utils/snack_bar.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_up_screen.dart';
import 'package:fyp_project/view/screens/create_account/account_type_screen.dart';
import 'package:fyp_project/view/screens/doctor_side/doctor_bottom_bar.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// Function to handle user signup
  Future<void> signup(
      String email, String password, String name, BuildContext context) async {
    try {
      setLoading = true;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Future.delayed(const Duration(seconds: 5));

      CustomSnackBarUtils.showTopSnackBar('sign up successfully', Colors.green);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AccountTypeScreen()));
      setLoading = false;
      notifyListeners();
    } catch (e) {
      setLoading = false;
      if (kDebugMode) {
        print(e.toString());
      }
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.red);
      notifyListeners();
      print('error in signup: $e');
    }
  }

// Function to handle user login
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      setLoading = true;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      CustomSnackBarUtils.showTopSnackBar('Login successfully', Colors.green);

      final user = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      user.get().then((value) {
        if (value.data()!['accountType'] == 'Patient') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => patientBottombar(
                        index: 0,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorpatientBottombar(
                        index: 0,
                      )));
        }
      });

      setLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('error in login: $e');
      }
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.red);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  // function for logout
  Future<void> logout(BuildContext context) async {
    try {
      setLoading = true;
      await FirebaseAuth.instance.signOut();
      Future.delayed(Duration(seconds: 5));
      CustomSnackBarUtils.showTopSnackBar('Logout successfully', Colors.green);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignInScreen()));

      setLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('error in logout: $e');
      }
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.red);
      setLoading = false;
      notifyListeners();
    }
  }

  // funtion to create account and store information of user

  Future<void> createaccount(
    String firstname,
    String lastname,
    String email,
    String password,
    String phoneNumber,
    String accountType,
    BuildContext context,
  ) async {
    try {
      setLoading = true;
      final users = FirebaseFirestore.instance.collection('users');
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await users.doc(uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'accountType': accountType,
      });
      Future.delayed(const Duration(seconds: 5));
      CustomSnackBarUtils.showTopSnackBar(
          'Account created successfully', Colors.green);
      if (accountType == 'Patient') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => patientBottombar(
                      index: 0,
                    )));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorpatientBottombar(
                      index: 0,
                    )));
      }
      setLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('error in create account: $e');
      }
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.red);
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }
}
