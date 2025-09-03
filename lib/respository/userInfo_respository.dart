import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:http/http.dart';

class UserinfoRespository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> getUserInfo(String token) async {
    try {
      final Response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.userUrl}', token);
      return Response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> notificationApi() async {
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final Response = await _apiServices.authorizedGetApi(
          '${Constants.baseUrl}${Constants.notificationUrl}', token!);
      print('response:$Response');
      return Response;
    } catch (e) {
      print('Error:$e');
      throw e;
    }
  }
}
