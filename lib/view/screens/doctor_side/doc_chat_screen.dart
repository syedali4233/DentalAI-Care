import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/doctor_side_components/chat_component_doc.dart';
import 'package:fyp_project/components/patient/home_components/search_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/utils/snack_bar.dart';
import 'package:fyp_project/view/screens/doctor_side/detail_chat_screen_doc.dart';
import 'package:fyp_project/model/get_conversation_model.dart';
import 'package:fyp_project/view_model/get_conversation_provider.dart';
import 'package:provider/provider.dart';

class DocChatScreen extends StatefulWidget {
  const DocChatScreen({super.key});

  @override
  State<DocChatScreen> createState() => _DocChatState();
}

class _DocChatState extends State<DocChatScreen> {
  TextEditingController searchController = TextEditingController();
  List<ConversationData> chatList = [];
  List<ConversationData> filterList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchChats();
    });
  }

  Future<void> fetchChats() async {
    final provider =
        Provider.of<GetConversationProvider>(context, listen: false);

    final conversations = await provider.getConversations();

    if (conversations != null && conversations.data.isNotEmpty) {
      setState(() {
        chatList = conversations.data;
        filterList = conversations.data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayList = searchController.text.isEmpty ? chatList : filterList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              30.toHeight,
              SizedBox(
                width: 340.w,
                child: Center(
                  child: SearchComponent(
                    hintText: 'Search Patients',
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        filterList = chatList
                            .where((chat) =>
                                ("${chat.otherUser.firstName} ${chat.otherUser.lastName}")
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
              20.toHeight,
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (displayList.isEmpty)
                const Center(child: Text("No Chats Found"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final chat = displayList[index];
                      return Dismissible(
                        key: Key(chat.conversationId),
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.w),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            chatList.remove(chat);
                            filterList.remove(chat);
                          });
                          CustomSnackBarUtils.showTopSnackBar(
                            'Chat deleted successfully',
                            maincolor.withOpacity(0.8),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: ChatComponentDoc(
                            ontap: () async {
                              String? userId = await SharedPreferencesManager
                                  .getUserIdFromSharedPreferences();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailChatScreenDoc(
                                    chat: {
                                      'conversationId': chat.conversationId,
                                      'receiverId':
                                          chat.otherUser.id, // Add receiverId
                                      'senderId':
                                          userId, // current logged-in user ID
                                      'name':
                                          "${chat.otherUser.firstName} ${chat.otherUser.lastName}",
                                      'message': chat.lastMessage.message,
                                      'time':
                                          chat.lastMessage.createdAt.toString(),
                                      'image': chat.otherUser.profileImage,
                                    },
                                  ),
                                ),
                              );
                              if (mounted) {
                                await fetchChats();
                              }
                            },
                            image: chat.otherUser.profileImage,
                            name:
                                "${chat.otherUser.firstName} ${chat.otherUser.lastName}",
                            message: chat.lastMessage.message,
                            time: chat.lastMessage.createdAt.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
