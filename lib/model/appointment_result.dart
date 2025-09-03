class AppointmentsResult {
  final bool? status;
  final String? msg;
  final List<Appointment>? appointments;

  AppointmentsResult({
    this.status,
    this.msg,
    this.appointments,
  });

  factory AppointmentsResult.fromJson(Map<String, dynamic> json) {
    return AppointmentsResult(
      status: json['status'] as bool?,
      msg: json['msg'] as String?,
      appointments: (json['appointments'] as List<dynamic>?)
          ?.map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'appointments': appointments?.map((e) => e.toJson()).toList(),
    };
  }
}

class Appointment {
  final String? id;
  final DoctorId? doctorId;
  final String? patientId;
  final DateTime? date;
  final String? time;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Appointment({
    this.id,
    this.doctorId,
    this.patientId,
    this.date,
    this.time,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'] as String?,
      doctorId: json['doctorId'] != null
          ? DoctorId.fromJson(json['doctorId'] as Map<String, dynamic>)
          : null,
      patientId: json['patientId'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      time: json['time'] as String?,
      status: json['status'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId?.toJson(),
      'patientId': patientId,
      'date': date?.toIso8601String(),
      'time': time,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }
}

class DoctorId {
  final String? id;
  final String? email;
  final String? role;

  DoctorId({
    this.id,
    this.email,
    this.role,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) {
    return DoctorId(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'role': role,
    };
  }
}
