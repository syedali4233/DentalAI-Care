import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_project/respository/auth_respository.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/utils/snack_bar.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/doctor_side/doctor_bottom_bar.dart';
import 'package:http_parser/http_parser.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final _myrepo = AuthRespository();

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setLoading = true;
    notifyListeners();

    try {
      final value = await _myrepo.signUpApi(data); // Single call

      print("Signup API Response: $value");

      if (value['status'] == true) {
        // Signup success

        CustomSnackBarUtils.showTopSnackBar(
          'Account created successfully',
          Colors.green,
        );

        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      } else {
        // Signup failed → show server message
        CustomSnackBarUtils.showTopSnackBar(
          value['msg'] ?? 'Signup failed',
          Colors.redAccent,
        );
      }
    } catch (error) {
      CustomSnackBarUtils.showTopSnackBar(error.toString(), Colors.redAccent);
      print("Signup Error: $error");
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginApis(dynamic data, BuildContext context) async {
    setLoading = true;
    notifyListeners();

    try {
      final value = await _myrepo.loginApi(data); // Single call

      print("Signup API Response: $value");

      if (value['status'] == true) {
        // Signup success
        String? token = value['token']?.toString();
        String? userId = value['id']?.toString();
        if (token != null && userId != null) {
          await SharedPreferencesManager.saveUserDataInSharedPreferences(
              token, userId);

          print('Stored token id in signup: $token');
          print('Stored user id in signup: $userId');
        }

        CustomSnackBarUtils.showTopSnackBar(
          'login successfully',
          Colors.green,
        );
        setLoading = false;
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) => DoctorpatientBottombar(
        //             index: 0,
        //           )),
        //   );
        if (value['role'] == 'nurse') {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DoctorpatientBottombar(
                      index: 0,
                    )),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => patientBottombar(
                      index: 0,
                    )),
          );
        }
      } else {
        // Signup failed → show server message
        CustomSnackBarUtils.showTopSnackBar(
          value['msg'] ?? 'login failed',
          Colors.redAccent,
        );
      }
    } catch (error) {
      CustomSnackBarUtils.showTopSnackBar(error.toString(), Colors.redAccent);
      print("Signup Error: $error");
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    try {
      setLoading = true;
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final value = await _myrepo.changePasswordApi(data, token!);

      setLoading = false;
      if (value['status'] == true) {
        CustomSnackBarUtils.showTopSnackBar(
          'password change successfully',
          Colors.green,
        );
      } else {
        CustomSnackBarUtils.showTopSnackBar(
          value["msg"].toString(),
          Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.redAccent);
      setLoading = false;
      print(" Error: $e");
    }
  }

  Future<void> deleteFuc(BuildContext context) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _myrepo.deleteApi(token!);
      if (response['status'] == true) {
        CustomSnackBarUtils.showTopSnackBar(
          'Delete account successfully',
          Colors.green,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      } else {
        CustomSnackBarUtils.showTopSnackBar(response['msg'], Colors.redAccent);
      }
    } catch (e) {
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.redAccent);
      setLoading = false;
      print(" Error: $e");
    }
  }

  Future<void> editUser(dynamic data, BuildContext context) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final value =
          await _myrepo.editProfile(data, token!); // data first, token second

      if (value['status'] == true) {
        CustomSnackBarUtils.showTopSnackBar('edit successfully', Colors.green);
      } else {
        CustomSnackBarUtils.showTopSnackBar(
            value["msg"].toString(), Colors.redAccent);
      }
    } catch (e) {
      CustomSnackBarUtils.showTopSnackBar(e.toString(), Colors.redAccent);
      print("Error: $e");
    }
  }

  Future<dynamic> uploadImage(File? image) async {
    final http.StreamedResponse response;
    dynamic responseJson;

    try {
      setLoading = true;

      if (image == null) {
        throw Exception('No image provided');
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://teeth-detetction-backend.onrender.com/api/user/upload-image'),
      );

      // Add the image file
      final file = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(file);

      // Await the token because it's a Future
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();

      // Add headers (Authorization + Content-Type)
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Send request
      response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        responseJson = json.decode(responseString);

        CustomSnackBarUtils.showTopSnackBar(
          responseJson['message'] ?? 'Image uploaded successfully',
          Colors.green,
        );

        setLoading = false;
        print("Image uploaded: ${responseJson['imageUrl']}");
        print(responseJson);
        print(response);
        return responseJson;
      } else {
        setLoading = false;
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      setLoading = false;
      print('Something went wrong: $e');
      rethrow;
    }
  }

  Future<dynamic> dectectIMg(File? image) async {
    final http.StreamedResponse response;
    dynamic responseJson;

    try {
      setLoading = true;

      if (image == null) {
        throw Exception('No image provided');
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://teeth-detetction-backend.onrender.com/api/detection/teeth-detection'),
      );

      // Add the image file
      final file = await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(file);

      // Await the token because it's a Future
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();

      // Add headers (Authorization + Content-Type)
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Send request
      response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        responseJson = json.decode(responseString);

        CustomSnackBarUtils.showTopSnackBar(
          responseJson['message'] ?? 'Image uploaded successfully',
          Colors.green,
        );

        setLoading = false;
        print("Image uploaded: ${responseJson['imageUrl']}");
        print(responseJson);
        print(response);
        return responseJson;
      } else {
        setLoading = false;
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      setLoading = false;
      print('Something went wrong: $e');
      rethrow;
    }
  }
}
