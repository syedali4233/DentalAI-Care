class GetConversationsModel {
  final bool status;
  final List<ConversationData> data;

  GetConversationsModel({
    required this.status,
    required this.data,
  });

  factory GetConversationsModel.fromJson(Map<String, dynamic> json) {
    return GetConversationsModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ConversationData.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ConversationData {
  final String conversationId;
  final OtherUser otherUser;
  final LastMessage lastMessage;
  final int unreadCount;

  ConversationData({
    required this.conversationId,
    required this.otherUser,
    required this.lastMessage,
    required this.unreadCount,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json['conversationId'] ?? '',
      otherUser: OtherUser.fromJson(json['otherUser'] ?? {}),
      lastMessage: LastMessage.fromJson(json['lastMessage'] ?? {}),
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'otherUser': otherUser.toJson(),
      'lastMessage': lastMessage.toJson(),
      'unreadCount': unreadCount,
    };
  }
}

class OtherUser {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImage;
  final String role;

  OtherUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.role,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    return OtherUser(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
      'role': role,
    };
  }
}

class LastMessage {
  final String message;
  final DateTime createdAt;
  final String messageType;

  LastMessage({
    required this.message,
    required this.createdAt,
    required this.messageType,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      message: json['message'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      messageType: json['messageType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'messageType': messageType,
    };
  }
}
