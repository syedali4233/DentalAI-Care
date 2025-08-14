import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/doctor_side_components/chat_component_doc.dart';
import 'package:fyp_project/components/patient/home_components/search_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/utils/snack_bar.dart';
import 'package:fyp_project/view/screens/doctor_side/detail_chat_screen_doc.dart';

class DocChatScreen extends StatefulWidget {
  const DocChatScreen({super.key});

  @override
  State<DocChatScreen> createState() => _DocChatState();
}

class _DocChatState extends State<DocChatScreen> {
  List<Map<String, dynamic>> chatList = [
    {
      'image': femalePatient2,
      'name': 'Marly Rodrigues',
      'message': 'hello are you free today?',
      'time': '10:30 AM'
    },
    {
      'image': maledoctor,
      'name': 'John Doe',
      'message': 'Can we reschedule our appointment?',
      'time': '9:15 AM'
    },
    {
      'image': femalePatient,
      'name': 'Jane Smith',
      'message': 'I have a question about my medication.',
      'time': '8:45 AM'
    },
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filterList = [];

  @override
  Widget build(BuildContext context) {
    // If search box is empty → show all chats, else show filtered
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
                            .where((chat) => chat['name']
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
              20.toHeight,
              ListView.builder(
                itemCount: displayList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final chat = displayList[index];
                  return Dismissible(
                    key: Key(chat.toString()),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.w),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        // Remove from display list
                        displayList.removeAt(index);

                        // Also remove from main list
                        chatList.removeWhere((c) => c['name'] == chat['name']);

                        // Refresh filtered list if search is active
                        if (searchController.text.isNotEmpty) {
                          filterList = chatList
                              .where((chat) => chat['name']
                                  .toLowerCase()
                                  .contains(
                                      searchController.text.toLowerCase()))
                              .toList();
                        }
                      });
                      CustomSnackBarUtils.showTopSnackBar(
                        'Chat deleted successfully',
                        maincolor.withOpacity(0.8),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: ChatComponentDoc(
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailChatScreenDoc(chat: chat),
                            ),
                          );
                        },
                        image: chat['image'],
                        name: chat['name'],
                        message: chat['message'],
                        time: chat['time'],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
