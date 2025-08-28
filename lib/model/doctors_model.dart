/// Top-level response model
class DoctorsResponse {
  final bool status;
  final String? msg;
  final List<Doctor> doctors;

  DoctorsResponse({
    required this.status,
    required this.doctors,
    this.msg,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      status: json['status'] == true,
      msg: json['msg'] as String?,
      doctors: (json['doctors'] as List<dynamic>? ?? [])
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'msg': msg,
        'doctors': doctors.map((e) => e.toJson()).toList(),
      };

  DoctorsResponse copyWith({
    bool? status,
    String? msg,
    List<Doctor>? doctors,
  }) {
    return DoctorsResponse(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      doctors: doctors ?? this.doctors,
    );
  }
}

/// Doctor item model
class Doctor {
  final String id; // maps _id
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dob;
  final int? phoneNo;
  final String? role;

  final String? speciality;
  final String? profileImage;
  final String? bio;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v; // maps __v

  Doctor({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.phoneNo,
    this.role,
    this.speciality,
    this.profileImage,
    this.bio,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    DateTime? _parseDate(dynamic value) {
      if (value == null) return null;
      if (value is String && value.isNotEmpty) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return Doctor(
      id: (json['_id'] ?? '') as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      dob: _parseDate(json['dob']),
      phoneNo: json['phoneNo'] is int
          ? json['phoneNo'] as int
          : int.tryParse('${json['phoneNo']}'),
      role: json['role'] as String?,
      speciality: json['speciality'] as String?,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      v: json['__v'] is int
          ? json['__v'] as int
          : int.tryParse('${json['__v']}'),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dob': dob?.toIso8601String(),
        'phoneNo': phoneNo,
        'role': role,
        'speciality': speciality,
        'profileImage': profileImage,
        'bio': bio,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  Doctor copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dob,
    int? phoneNo,
    String? role,
    String? speciality,
    String? profileImage,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Doctor(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      phoneNo: phoneNo ?? this.phoneNo,
      role: role ?? this.role,
      speciality: speciality ?? this.speciality,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  String toString() =>
      'Doctor(id: $id, name: ${firstName ?? ''} ${lastName ?? ''}, email: $email)';
}
