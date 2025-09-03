import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/patient/profile_components/profile_screen_components.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/images_path.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/model/appointment_model.dart';
import 'package:fyp_project/utils/shared_preference_manager.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view/screens/auth_screens/sign_in_screen.dart';
import 'package:fyp_project/view/screens/doctor_side/doc_change_password.dart';
import 'package:fyp_project/view/screens/patient/appointments_screen.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:fyp_project/view_model/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      File file = File(pickedFile.path); // actual file

      setState(() {
        _imageFile = file;
      });

      final provider = Provider.of<AuthProvider>(context, listen: false);
      provider.uploadImage(file); // pass file object
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    //final profileData = Provider.of<ProfileProvider>(context).profileData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                10.toHeight,
                Center(
                  child: Stack(
                    children: [
                      Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          if (value.userResponse == null) {
                            return ShimmerComponents.profilePictureShimmer();
                          }

                          final user = value.userResponse!.userInfo;

                          ImageProvider? backgroundImage;
                          if (_imageFile != null) {
                            backgroundImage = FileImage(_imageFile!);
                          } else if (user.profileImage != null &&
                              user.profileImage.isNotEmpty) {
                            backgroundImage = NetworkImage(user.profileImage);
                          }

                          return CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: backgroundImage,
                            child: backgroundImage == null
                                ? Icon(Icons.person,
                                    size: 40.sp, color: Colors.white)
                                : null,
                          );
                        },
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
                Center(
                  child: Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      if (value.userResponse == null) {
                        return ShimmerComponents.textShimmer();
                      }
                      final user = value.userResponse!.userInfo;
                      return Text(
                        user.fullName,
                        style: maintext,
                      );
                    },
                  ),
                ),
                10.toHeight,
                30.toHeight,
                ProfileScreenComponents(
                  title: 'Change Password',
                  image: profileHeart,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DocChangePassword()));
                  },
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
                  title: 'Appointments',
                  image: profileHeart,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppointmentsScreen()));
                  },
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
                  title: 'Delete Account',
                  image: wallet,
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
                  title: 'Logout',
                  image: logoutIcon,
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Logout"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await SharedPreferencesManager
                                    .removeUserDetailsFromSharedPreferences();

                                Navigator.pop(context); // Close dialog
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                );
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                5.toHeight,
                SizedBox(
                  width: 300.w,
                  child: Divider(
                    // ignore: deprecated_member_use
                    color: maincolor.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
