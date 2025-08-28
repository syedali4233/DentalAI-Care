class UserResponse {
  final bool status;
  final UserInfo userInfo;

  UserResponse({
    required this.status,
    required this.userInfo,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      status: json['status'] ?? false,
      userInfo: UserInfo.fromJson(json['userInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'userInfo': userInfo.toJson(),
    };
  }
}

class UserInfo {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime? dob;
  final int phoneNo;
  final String role;
  final String speciality;
  final String profileImage;
  final String bio;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.dob,
    required this.phoneNo,
    required this.role,
    required this.speciality,
    required this.profileImage,
    required this.bio,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      phoneNo: json['phoneNo'] ?? 0,
      role: json['role'] ?? '',
      speciality: json['speciality'] ?? '',
      profileImage: json['profileImage'] ?? '',
      bio: json['bio'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
  }

  // Helper methods
  String get fullName => '$firstName $lastName';

  bool get hasProfileImage => profileImage.isNotEmpty;

  bool get hasBio => bio.isNotEmpty;

  String get formattedPhoneNo => '+$phoneNo';

  // Age calculation from date of birth
  int? get age {
    if (dob == null) return null;
    final now = DateTime.now();
    int age = now.year - dob!.year;
    if (now.month < dob!.month ||
        (now.month == dob!.month && now.day < dob!.day)) {
      age--;
    }
    return age;
  }
}

// Example usage:
// 
// // Parse from JSON
// final jsonString = '{"status": true, "userInfo": {...}}';
// final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
// final UserResponse userResponse = UserResponse.fromJson(jsonMap);
//
// // Access data
// print(userResponse.userInfo.fullName);
// print(userResponse.userInfo.email);
// print(userResponse.userInfo.age);
//
// // Convert back to JSON
// final Map<String, dynamic> jsonOutput = userResponse.toJson();