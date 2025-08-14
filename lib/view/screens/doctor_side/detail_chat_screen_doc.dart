import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/doctor_side_components/chat_component_doc.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';

class DetailChatScreenDoc extends StatefulWidget {
  final Map<String, dynamic> chat;
  const DetailChatScreenDoc({super.key, required this.chat});

  @override
  State<DetailChatScreenDoc> createState() => _DetailChatScreenDocState();
}

class _DetailChatScreenDocState extends State<DetailChatScreenDoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.chat['name']!,
          style: maintext.copyWith(color: Colors.black, fontSize: 16.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            20.toHeight,
            ChatComponentDoc(
                ontap: () {},
                image: widget.chat['image']!,
                name: widget.chat['name']!,
                message: widget.chat['message']!,
                time: widget.chat['time']!),
          ],
        ),
      ),
    );
  }
}
