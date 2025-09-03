import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_project/model/appointment_result.dart';
import 'package:fyp_project/respository/appointments_respository.dart';

class AppointmentsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AppointmentsResult? appointments;
  final _myrepo = AppointmentsRespository();

  Future<void> appointmentsFuc() async {
    try {
      setLoading = true;
      final data = await _myrepo.appointsmentsApi(); // returns decoded JSON
      appointments = AppointmentsResult.fromJson(data);
      print(data);
    } catch (e) {
      print('Error fetching appointments: $e');
    } finally {
      setLoading = false;
    }
  }
}
