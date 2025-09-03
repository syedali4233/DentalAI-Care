import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/view_model/get_conversation_provider.dart';
import 'package:provider/provider.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/model/chathistory_model.dart';

class DetailChatScreenDoc extends StatefulWidget {
  final Map<String, dynamic> chat;
  const DetailChatScreenDoc({super.key, required this.chat});

  @override
  State<DetailChatScreenDoc> createState() => _DetailChatScreenDocState();
}

class _DetailChatScreenDocState extends State<DetailChatScreenDoc> {
  final TextEditingController _messageController = TextEditingController();
  String? _currentUserId;
  final List<ChatMessage> _localMessages = [];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final nowIso = DateTime.now().toIso8601String();
    final ChatMessage optimistic = ChatMessage(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      sender: User(
        id: _currentUserId ?? '',
        firstName: '',
        lastName: '',
        role: '',
        profileImage: '',
      ),
      receiver: User(
        id: widget.chat['receiverId'] ?? '',
        firstName: '',
        lastName: '',
        role: '',
        profileImage: '',
      ),
      message: text,
      messageType: 'text',
      fileUrl: '',
      isRead: false,
      conversationId: widget.chat['conversationId'] ?? '',
      isDeleted: false,
      createdAt: nowIso,
      updatedAt: nowIso,
      v: 0,
    );

    setState(() {
      _localMessages.add(optimistic);
      _messageController.clear();
    });

    // Fire-and-forget send via provider
    final provider =
        Provider.of<GetConversationProvider>(context, listen: false);
    provider
        .sendMessage(receiverId: widget.chat['receiverId'], message: text)
        .then((serverMessage) {
      if (serverMessage != null && mounted) {
        // Replace the optimistic message with authoritative server message
        setState(() {
          // remove last optimistic if it matches message text and local id prefix
          if (_localMessages.isNotEmpty &&
              _localMessages.last.message == text &&
              _localMessages.last.id.startsWith('local_')) {
            _localMessages.removeLast();
          }
          _localMessages.add(serverMessage);
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send. Will retry later.')),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _currentUserId =
          await SharedPreferencesManager.getUserIdFromSharedPreferences();
      await Provider.of<GetConversationProvider>(context, listen: false)
          .gethistorychat(widget.chat['receiverId']);
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          widget.chat['name'],
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Consumer<GetConversationProvider>(
        builder: (context, value, child) {
          if (value.chatHistoryResponse == null) {
            return Center(
              child: Text(
                "No messages yet",
                style: TextStyle(color: Colors.grey, fontSize: 16.sp),
              ),
            );
          }
          final chatHistory = value.chatHistoryResponse!.data;
          final combinedMessages = [...chatHistory, ..._localMessages];
          return Column(
            children: [
              /// Chat Messages List
              Expanded(
                child: combinedMessages.isEmpty
                    ? Center(
                        child: Text(
                          "No messages yet",
                          style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        itemCount: combinedMessages.length,
                        itemBuilder: (context, index) {
                          final message = combinedMessages[index];
                          final bool isSender = _currentUserId != null &&
                              message.sender.id == _currentUserId;
                          final DateTime? createdAt =
                              DateTime.tryParse(message.createdAt);
                          final String timeLabel = createdAt != null
                              ? TimeOfDay.fromDateTime(createdAt)
                                  .format(context)
                              : '';

                          return Align(
                            alignment: isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                              padding: EdgeInsets.all(10.w),
                              constraints: BoxConstraints(maxWidth: 250.w),
                              decoration: BoxDecoration(
                                color:
                                    isSender ? Colors.blue : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.message,
                                    style: TextStyle(
                                      color: isSender
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Text(
                                      timeLabel,
                                      style: TextStyle(
                                        color: isSender
                                            ? Colors.white.withOpacity(0.7)
                                            : Colors.grey,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              /// Message Input Field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
