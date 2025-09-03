class ChatHistoryResponse {
  final bool status;
  final List<ChatMessage> data;
  final Pagination pagination;

  ChatHistoryResponse({
    required this.status,
    required this.data,
    required this.pagination,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ChatHistoryResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ChatMessage.fromJson(e))
              .toList() ??
          [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class ChatMessage {
  final String id;
  final User sender;
  final User receiver;
  final String message;
  final String messageType;
  final String fileUrl;
  final bool isRead;
  final String conversationId;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final int v;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.messageType,
    required this.fileUrl,
    required this.isRead,
    required this.conversationId,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'] ?? '',
      sender: User.fromJson(json['sender'] ?? {}),
      receiver: User.fromJson(json['receiver'] ?? {}),
      message: json['message'] ?? '',
      messageType: json['messageType'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      isRead: json['isRead'] ?? false,
      conversationId: json['conversationId'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'message': message,
      'messageType': messageType,
      'fileUrl': fileUrl,
      'isRead': isRead,
      'conversationId': conversationId,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String role;
  final String profileImage;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'profileImage': profileImage,
    };
  }
}

class Pagination {
  final int page;
  final int limit;

  Pagination({
    required this.page,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 50,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
    };
  }
}
