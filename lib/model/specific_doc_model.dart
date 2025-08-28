// specific_doctor_model.dart
class SpecificDoctorResponse {
  bool status;
  String msg;
  Doctor doctor;

  SpecificDoctorResponse({
    required this.status,
    required this.msg,
    required this.doctor,
  });

  factory SpecificDoctorResponse.fromJson(Map<String, dynamic> json) {
    return SpecificDoctorResponse(
      status: json['status'],
      msg: json['msg'],
      doctor: Doctor.fromJson(json['doctor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'doctor': doctor.toJson(),
    };
  }
}

class Doctor {
  String id;
  String firstName;
  String lastName;
  String email;
  String role;
  String dob;
  String phoneNo;
  String speciality;
  String profileImage;
  String bio;
  String createdAt;
  String updatedAt;
  int v;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.dob,
    required this.phoneNo,
    required this.speciality,
    required this.profileImage,
    required this.bio,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      dob: json['dob'] ?? '',
      phoneNo: json['phoneNo'].toString(),
      speciality: json['speciality'] ?? '',
      profileImage: json['profileImage'] ?? '',
      bio: json['bio'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'role': role,
      'dob': dob,
      'phoneNo': phoneNo,
      'speciality': speciality,
      'profileImage': profileImage,
      'bio': bio,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
