import 'package:flutter/material.dart';
import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentsRespository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> appointsmentsApi() async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.apppointsUrl}', token!);
      print(response);
      return response;
    } catch (e) {
      print('error$e');
      throw e;
    }
  }
}
