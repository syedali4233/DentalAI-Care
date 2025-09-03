import 'package:flutter/material.dart';
import 'package:fyp_project/model/appointment_model.dart';
import 'package:fyp_project/model/doctors_model.dart';
import 'package:fyp_project/model/specific_doc_model.dart';
import 'package:fyp_project/respository/doctors_respository.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/utils/snack_bar.dart';

class DoctorsProvider extends ChangeNotifier {
  bool _loading = false;
  bool get isLoading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  AppointmentResponse? appointments;
  SpecificDoctorResponse? specificDoctor;
  DoctorsResponse? _doctorResponse;
  DoctorsResponse? get doctorResponse => _doctorResponse;

  final _myrepo = DoctorsRespository();
  Future<void> getAlldoctors() async {
    _doctorResponse = null;
    notifyListeners();
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();
      final value = await _myrepo.getDoctorsApi(token!);
      if (value != null) {
        notifyListeners();
        _doctorResponse = DoctorsResponse.fromJson(value);
        print(_doctorResponse!.doctors);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getSpecificDoc(String id) async {
    specificDoctor = null;
    notifyListeners();
    try {
      String? token =
          await SharedPreferencesManager.getUserTokenFromSharedPreferences();

      final response = await _myrepo.getSpecificApi(id, token!);
      if (response != null) {
        specificDoctor = SpecificDoctorResponse.fromJson(response);
        print(specificDoctor!.doctor.firstName);
        notifyListeners();
        print(response);
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> bookAppointment(dynamic data, String id) async {
    try {
      setLoading = true;

      final response = await _myrepo.bookApoApi(data, id);
      print(response);
      CustomSnackBarUtils.showTopSnackBar(
          'Book Appointment successfully', Colors.green);
      setLoading = false;
      return response;
    } catch (e) {
      CustomSnackBarUtils.showTopSnackBar('${e.toString()}', Colors.red);
      setLoading = false;
      print('error:${e.toString()}');
    }
  }

  Future<void> getAppointmentfuc() async {
    try {
      final response = await _myrepo.getAppointmentsApi();
      if (response != null) {
        appointments = AppointmentResponse.fromJson(response);
        print(appointments!.appointments);
        notifyListeners();
        print(response);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  Future<void> acceptfuc(String id) async {
    try {
      final response = await _myrepo.getAcceptApi(id);
      print(response);
      notifyListeners();
      await getAppointmentfuc();
      return response;
    } catch (e) {
      print('${e.toString()}');
      throw e;
    }
  }

  Future<void> rejectfuc(String id) async {
    try {
      final response = await _myrepo.getrejectApi(id);
      print("Reject Response: $response");

      appointments?.appointments.removeWhere((a) => a.id == id);

      notifyListeners();

      return response;
    } catch (e) {
      print('Error in rejectfuc: ${e.toString()}');
      throw e;
    }
  }
}
