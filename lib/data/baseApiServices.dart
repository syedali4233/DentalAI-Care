import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> postApi(dynamic data, String url);
  Future<dynamic> getApi(String url);
  Future<dynamic> putApi(dynamic data, String url, String token);
  Future<dynamic> authorizedPutApi(var data, String url, String token);
  Future<dynamic> authorizedGetApi(String url, String token);
  Future<dynamic> authorizaedDeleteApi(String token, url);
  Future<dynamic> authorizedPostApi(dynamic data, String url, String token);
  Future<dynamic> authorizedPutApiWithBody(String url, String token);
}
