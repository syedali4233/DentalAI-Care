import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';

class ChatRespository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> chatApi(dynamic data) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedPostApi(
          data, '${Constants.baseUrl}${Constants.sendmsgUrl}', token!);
      print(response);
      return response;
    } catch (e) {
      print('error:${e.toString()}');
      throw e;
    }
  }

  Future<dynamic> getchathistoryApi(String id) async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.gethistoryUrl}${id}', token!);
      print('response:$response');
      return response;
    } catch (e) {
      print('error:${e.toString()}');
      throw e;
    }
  }

  Future<dynamic> getconversionApi() async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.getconUrl}', token!);
      print('response:$response');
      return response;
    } catch (e) {
      print('error:${e.toString()}');
      throw e;
    }
  }
}
