import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/profile_components/profile_screen_components.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view/screens/doctor_side/doc_change_password.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DocProfileScreen extends StatefulWidget {
  const DocProfileScreen({super.key});

  @override
  State<DocProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<DocProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      provider.userDetails().then((_) {
        textController.text =
            provider.userResponse!.userInfo.bio; // Set bio in text field
      });
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool isEditing = false;
  TextEditingController textController =
      TextEditingController(text: "Tell about us!");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.toHeight,
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? Icon(Icons.person,
                                size: 40.sp, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 20.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                5.toHeight,
                Consumer<ProfileProvider>(
                  builder: (context, value, child) {
                    if (value.userResponse == null) {
                      return ShimmerComponents.textShimmer();
                    }
                    final user = value.userResponse!.userInfo;
                    return Center(
                      child: Text(
                        'Dr. ${user.fullName} ',
                        style: maintext.copyWith(fontSize: 14.sp),
                      ),
                    );
                  },
                ),
                20.toHeight,
                Center(
                  child: Stack(
                    children: [
                      isEditing
                          ? TextField(
                              controller: textController,
                              autofocus: true,
                              style: const TextStyle(fontSize: 16),
                            )
                          : Text(
                              textController.text,
                              style: const TextStyle(fontSize: 16),
                            ),
                      Positioned(
                        right: 0,
                        top: 10,
                        child: Consumer<AuthProvider>(
                          builder: (context, value, child) {
                            return IconButton(
                              icon: Icon(isEditing ? Icons.check : Icons.edit,
                                  color: Colors.blue),
                              onPressed: () async {
                                if (isEditing) {
                                  // When saving
                                  final data = {'bio': textController.text};
                                  value.editUser(data, context);
                                  // ✅ Re-fetch updated data
                                  final profileProvider =
                                      Provider.of<ProfileProvider>(context,
                                          listen: false);
                                  await profileProvider.userDetails();

                                  setState(() {
                                    textController.text = profileProvider
                                        .userResponse!.userInfo.bio;
                                  });
                                }
                                setState(() {
                                  isEditing = !isEditing; // Toggle edit mode
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                20.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          heartbeat,
                          scale: 4.sp,
                        ),
                        Text(
                          'Patient Treated',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '215',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: maincolor,
                        width: sqrt1_2,
                        thickness: sqrt1_2,
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          fire,
                          scale: 4.sp,
                        ),
                        Text(
                          'Rating',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '4.5/5.0',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: maincolor,
                        width: sqrt1_2,
                        thickness: sqrt1_2,
                      ),
                    ),
                    Column(
                      children: [
                        Image.asset(
                          weight,
                          scale: 4.sp,
                        ),
                        Text(
                          'Total Earning',
                          style: TextStyle(color: maincolor, fontSize: 10.sp),
                        ),
                        Text(
                          '\$ 21044',
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                30.toHeight,
                5.toHeight,
                const ProfileScreenComponents(
                  title: 'Payment Method',
                  image: wallet,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.1),
                  ),
                ),
                5.toHeight,
                ProfileScreenComponents(
                    ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DocEditScreen()));
                    },
                    title: 'Change Password',
                    image: "assets/editIcon.png"),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.1),
                  ),
                ),
                5.toHeight,
                const ProfileScreenComponents(
                  title: 'FAQS',
                  image: faqsImage,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                ProfileScreenComponents(
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Account',
                            style: maintext,
                          ),
                          content: Text(
                            'Are you sure?',
                            style: simpletext,
                          ),
                          actions: [
                            Consumer<AuthProvider>(
                              builder: (context, value, child) {
                                return TextButton(
                                  onPressed: () {
                                    value.deleteFuc(context);
                                  },
                                  child: const Text('Delete'),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  title: 'Delete account',
                  image: logoutIcon,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
                5.toHeight,
                ProfileScreenComponents(
                  ontap: () {
                    // Provider.of<AuthProvider>(context, listen: false)
                    //     .logout(context);
                  },
                  title: 'Logout',
                  image: logoutIcon,
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
