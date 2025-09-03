import 'dart:io';

import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:http/http.dart';

class AuthRespository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApi(
          data, "${Constants.baseUrl}${Constants.signupUrl}");

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postApi(
          data, "${Constants.baseUrl}${Constants.loginUrl}");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> changePasswordApi(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.putApi(
          data, '${Constants.baseUrl}${Constants.changePasswordUrl}', token);
      print("network response: ${response}");

      print("respository${data}");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteApi(String token) async {
    try {
      dynamic response = await _apiServices.authorizaedDeleteApi(
          token, '${Constants.baseUrl}${Constants.deleteUrl}');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editProfile(
    dynamic data,
    String token,
  ) async {
    try {
      dynamic response = await _apiServices.putApi(
          data, '${Constants.baseUrl}${Constants.ediyUrl}', token);
      print('response${response}');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
