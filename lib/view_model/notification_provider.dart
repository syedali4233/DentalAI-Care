import 'package:flutter/material.dart';
import 'package:fyp_project/model/notification_model.dart';
import 'package:fyp_project/respository/userInfo_respository.dart';

class NotificationProvider extends ChangeNotifier {
  bool _loading = false;
  bool get isLoading => _loading;

  List<NotificationModel> notifications = [];

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final _myrepo = UserinfoRespository();
  Future<void> notificationfuc() async {
    setLoading = true;
    try {
      final response = await _myrepo.notificationApi();
      print("API Raw Response: $response");

      if (response is Map && response['notification'] != null) {
        notifications = (response['notification'] as List)
            .map(
                (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        notifications = [];
      }

      notifyListeners();
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      setLoading = false;
    }
  }
}
