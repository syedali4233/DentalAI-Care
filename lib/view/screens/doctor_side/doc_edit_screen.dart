import 'package:flutter/material.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

class DocEditScreen extends StatefulWidget {
  const DocEditScreen({super.key});

  @override
  State<DocEditScreen> createState() => _DocEditScreenState();
}

class _DocEditScreenState extends State<DocEditScreen> {
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bio',
          style: maintext,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Write your bio:",
              style: maintext.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bioController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter your bio here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: () {
                      final bioText = _bioController.text;
                      // Save bio logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Bio Saved: $bioText")),
                      );
                      final data = {'bio': _bioController.text};
                      value.editUser(data, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
