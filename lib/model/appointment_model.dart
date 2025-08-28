class AppointmentResponse {
  final bool status;
  final String msg;
  final List<Appointment> appointments;

  AppointmentResponse({
    required this.status,
    required this.msg,
    required this.appointments,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      status: json['status'],
      msg: json['msg'],
      appointments: (json['appointments'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList(),
    );
  }
}

class Appointment {
  final String id;
  final String doctorId;
  final Patient patient;
  final DateTime date;
  final String time;
  final String status;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.patient,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      doctorId: json['doctorId'],
      patient: Patient.fromJson(json['patientId']), // nested object parsed here
      date: DateTime.parse(json['date']),
      time: json['time'],
      status: json['status'],
    );
  }
}

class Patient {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImage;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }
}
