import 'package:fyp_project/constants/app_urls.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:fyp_project/data/network_api_services.dart';
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
}
