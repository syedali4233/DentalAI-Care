import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  Map<String, dynamic> _profileData = {};

  Map<String, dynamic> get profileData => _profileData;

  Future<void> fetchProfileData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No logged-in user found');
      return;
    }

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (docSnapshot.exists) {
        _profileData = docSnapshot.data()!;
        print('Profile data: $_profileData');
        notifyListeners();
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error fetching profile data: $error');
    }
  }
}
