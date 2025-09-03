import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_project/model/chathistory_model.dart';
import 'package:fyp_project/model/get_conversation_model.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:http/http.dart' as http;

class GetConversationProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  ChatHistoryResponse? _ChatHistoryResponse;
  ChatHistoryResponse? get chatHistoryResponse => _ChatHistoryResponse;
  // Fetch conversations
  Future<GetConversationsModel?> getConversations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();

      final response = await http.get(
        Uri.parse(
            "https://teeth-detetction-backend.onrender.com/api/chat/conversations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GetConversationsModel.fromJson(data);
      } else {
        _error = "Error: ${response.statusCode}";
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _error = "Exception: $e";
      notifyListeners();
      print("Exception in getConversations: $e");
      return null;
    }
  }

  Future<dynamic> gethistorychat(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();

      final response = await http.get(
        Uri.parse(
            "https://teeth-detetction-backend.onrender.com/api/chat/history/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      _isLoading = false;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _ChatHistoryResponse = ChatHistoryResponse.fromJson(data);
        print("Chat History Response: ${jsonEncode(data)}"); // print JSON
        notifyListeners(); // refresh UI
        print(_ChatHistoryResponse);
        return _ChatHistoryResponse;
      } else {
        _error = "Error: ${response.statusCode}";
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return null;
      }
    } catch (e) {
      _isLoading = false;
      _error = "Exception: $e";
      notifyListeners();
      print(e);
      throw e;
    }
  }

  Future<ChatMessage?> sendMessage({
    required String receiverId,
    required String message,
  }) async {
    try {
      final String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final uri = Uri.parse(
          "https://teeth-detetction-backend.onrender.com/api/chat/send");
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "receiverId": receiverId,
          "message": message,
          "messageType": "text",
          "fileUrl": "",
        }),
      );
      debugPrint('sendMessage status: ${response.statusCode}');
      debugPrint('sendMessage body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final data = body['data'] as Map<String, dynamic>?;
        if (data != null) {
          return ChatMessage.fromJson(data);
        }
        return null;
      }
      _error = "Error: ${response.statusCode}";
      return null;
    } catch (e) {
      _error = "Exception: $e";
      return null;
    }
  }
}
