import 'dart:convert';

import 'dart:io';

import 'package:fyp_project/data/app_exceptions.dart';
import 'package:fyp_project/data/baseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connnection');
    }
    return responseJson;
  }

  @override
  Future authorizedGetApi(String url, String token) async {
    // TODO: implement authorizedGetApi
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connection');
    } on FormatException catch (e) {
      throw FetchDataException('Invalid response format: ${e.message}');
    } catch (e) {
      throw FetchDataException('Unexpected error: ${e.toString()}');
    }
    return responseJson;
  }

  @override
  Future authorizedPutApi(data, String url, String token) {
    // TODO: implement authorizedPutApi
    throw UnimplementedError();
  }

  @override
  Future getApi(String url) {
    // TODO: implement getApi
    throw UnimplementedError();
  }

  @override
  Future postApi(dynamic data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet connnection');
    }
    return responseJson;
  }

  @override
  Future putApi(dynamic data, String url, String token) async {
    // TODO: implement putApi
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));

      responseJson = returnResponse(response);
      print('network ${data}');
    } on SocketException catch (e) {
      throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  @override
  Future authorizaedDeleteApi(String token, url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      print("Status Code: ${response.statusCode}");
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error accorded while communicating with server-----> ${response.statusCode}');
    }
  }

  @override
  Future authorizedPostApi(dynamic data, String url, String token) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException('$e');
    }
    return responseJson;
  }

  @override
  Future authorizedPutApiWithBody(String url, String token) async {
    try {
      dynamic responseJson;
      print(url);
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('response:$response');
      responseJson = returnResponse(response);
      print("cxz$responseJson");
    } on SocketException catch (e) {
      throw FetchDataException('$e');
    }
  }
}
