// import 'package:flutter/material.dart';
// import 'package:fyp_project/model/chathistory_model.dart';
// import 'package:fyp_project/respository/chat_respository.dart';

// class ChatProvider extends ChangeNotifier {
//   bool _loading = false;
//   bool get isLoading => _loading;

//   ChatHistory? _chatHistory;
//   ChatHistory? get chatHistory => _chatHistory;

//   List<dynamic> _conversations = [];
//   List<dynamic> get conversations => _conversations;

//   final ChatRespository _myrepo = ChatRespository();

//   /// Set loading state
//   set setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   /// Send chat message
//   Future<Map<String, dynamic>> chatFuc(Map<String, dynamic> data) async {
//     try {
//       final response = await _myrepo.chatApi(data);

//       if (response != null && response["status"] == true) {
//         return response;
//       } else {
//         return {
//           "status": false,
//           "message": response?["message"] ?? "Something went wrong"
//         };
//       }
//     } catch (e) {
//       debugPrint("Error sending message: $e");
//       return {"status": false, "message": e.toString()};
//     }
//   }

//   /// Get chat history by conversation ID
//   Future<void> gethistoryFucn(String conversationId) async {
//     try {
//       setLoading = true;
//       final response = await _myrepo.getchathistoryApi(conversationId);

//       if (response != null && response["status"] == true) {
//         _chatHistory = ChatHistory.fromJson(response);
//       } else {
//         _chatHistory = ChatHistory(
//           status: false,
//           data: [],
//           pagination: Pagination(page: 1, limit: 10),
//         );
//       }

//       setLoading = false;
//       notifyListeners();
//     } catch (e) {
//       setLoading = false;
//       debugPrint("Error fetching history: $e");
//       rethrow;
//     }
//   }

//   /// Get conversation list
//   Future<void> getconversationFuct() async {
//     try {
//       setLoading = true;
//       final response = await _myrepo.getconversionApi();

//       _conversations = response["data"] ?? [];
//       setLoading = false;
//       notifyListeners();
//     } catch (e) {
//       setLoading = false;
//       debugPrint("Error fetching conversations: $e");
//       rethrow;
//     }
//   }
// }
