import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorsRespository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getDoctorsApi(String token) async {
    try {
      dynamic response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.getDoctorsUrl}', token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getSpecificApi(String id, String token) async {
    try {
      dynamic response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.getspecificUrl}${id}', token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> bookApoApi(
    dynamic data,
    String id,
  ) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedPostApi(data,
          '${Constants.baseUrl}${Constants.bookAppointmentUrl}${id}', token!);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<dynamic> getAppointmentsApi() async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.getAppointmentsUrl}', token!);
      return response;
    } catch (e) {
      print('${e.toString()}');
    }
  }

  Future<dynamic> getAcceptApi(
    String id,
  ) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedPutApiWithBody(
        '${Constants.baseUrl}${Constants.acceptUrl}${id}',
        token!,
      );
      return response;
    } catch (e) {
      print('${e.toString()}');
      throw e;
    }
  }

  Future<dynamic> getrejectApi(
    String id,
  ) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedPutApiWithBody(
        '${Constants.baseUrl}${Constants.rejectUrl}${id}',
        token!,
      );
      return response;
    } catch (e) {
      print('${e.toString()}');
      throw e;
    }
  }
}
