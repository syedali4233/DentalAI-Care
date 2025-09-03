class NotificationModel {
  final String? id;
  final String? userId;
  final String? type;
  final String? message;
  final bool? isRead;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    this.userId,
    this.type,
    this.message,
    this.isRead,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      type: json['type'] ?? "",
      message: json['message'] ?? "No message",
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
