import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/model/user_info_model.dart';
import 'package:fyp_project/respository/userInfo_respository.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';

class ProfileProvider extends ChangeNotifier {
  UserResponse? _userResponse;
  UserResponse? get userResponse => _userResponse;
  bool _loading = false;
  bool get isLoading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final _myrepo = UserinfoRespository();
  Future<void> userDetails() async {
    setLoading = true;
    String? token =
        await SharedPreferencesManager.getUserTokenFromSharedPreferences();
    final value = await _myrepo.getUserInfo(token!);
    if (value != null) {
      _userResponse = UserResponse.fromJson(value);
      print(_userResponse!.userInfo.fullName);
    }
    setLoading = false;
  }
}
