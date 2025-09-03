import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/auth_components/button_component.dart';
import 'package:fyp_project/constants/colors.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/view_model/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DetecionScreen extends StatefulWidget {
  const DetecionScreen({super.key});

  @override
  State<DetecionScreen> createState() => _DetecionScreenState();
}

class _DetecionScreenState extends State<DetecionScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic>? analysisResult;

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        analysisResult = null; // reset previous analysis
      });
    }
  }

  Future<void> _analyzeImage() async {
    if (_imageFile == null) return;

    final provider = Provider.of<AuthProvider>(context, listen: false);
    try {
      // Hit API
      final response = await provider.dectectIMg(_imageFile!);

      // Save data for UI
      setState(() {
        analysisResult = response['data']['analysis'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error analyzing image: $e')),
      );
    }
  }

  Widget _buildAnalysisCard(String title, String content) {
    return Card(
      color: maincolor.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
            SizedBox(height: 6.h),
            Text(content, style: TextStyle(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _generateCardsFromResult(
      Map<String, dynamic> analysis) {
    List<Map<String, String>> cards = [];

    // Teeth Health
    final teethHealth = analysis['teeth_health_level'];
    if (teethHealth != null) {
      cards.add({
        'title': 'Teeth Health',
        'content':
            "Score: ${teethHealth['score']}\nGrade: ${teethHealth['grade']}\nSummary: ${teethHealth['summary']}"
      });
    }

    // Urgency
    final urgency = analysis['urgency'];
    if (urgency != null) {
      cards.add({
        'title': 'Urgency',
        'content':
            "Level: ${urgency['level']}\nReason: ${urgency['reason']}\nTimeline: ${urgency['timeline']}"
      });
    }

    // Image quality
    cards.add({
      'title': 'Image Quality',
      'content': analysis['image_quality'] ?? 'N/A'
    });

    // Teeth condition
    cards.add({
      'title': 'Teeth Condition',
      'content': analysis['teeth_condition'] ?? 'N/A'
    });

    // Gum condition
    cards.add({
      'title': 'Gum Condition',
      'content': analysis['gum_condition'] ?? 'N/A'
    });

    // Identified diseases
    final diseases = analysis['identified_diseases'] as List<dynamic>?;
    if (diseases != null) {
      for (var disease in diseases) {
        cards.add({
          'title': disease['disease_name'] ?? 'Disease',
          'content':
              "Severity: ${disease['severity']}\nDescription: ${disease['description']}\nAffected Areas: ${disease['affected_areas']}"
        });
      }
    }

    // Decay analysis
    final decay = analysis['decay_analysis'];
    if (decay != null) {
      cards.add({
        'title': 'Decay Analysis',
        'content':
            "Present: ${decay['present']}\nType: ${decay['type']}\nSeverity: ${decay['severity']}\nDescription: ${decay['description']}"
      });
    }

    // Discoloration
    final discoloration = analysis['discoloration'];
    if (discoloration != null) {
      cards.add({
        'title': 'Discoloration',
        'content':
            "Present: ${discoloration['present']}\nType: ${discoloration['type']}\nCauses: ${discoloration['causes']}\nDescription: ${discoloration['description']}"
      });
    }

    // Plaque & Tartar
    final plaque = analysis['plaque_tartar'];
    if (plaque != null) {
      cards.add({
        'title': 'Plaque & Tartar',
        'content':
            "Present: ${plaque['present']}\nSeverity: ${plaque['severity'] ?? 'N/A'}\nDescription: ${plaque['description'] ?? 'N/A'}"
      });
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text('Teeth Analyzer', style: maintext),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            10.toHeight,
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: maincolor,
                borderRadius: BorderRadius.circular(12.r),
                image: _imageFile != null
                    ? DecorationImage(
                        image: FileImage(_imageFile!), fit: BoxFit.cover)
                    : null,
              ),
              child: _imageFile == null
                  ? const Center(
                      child: Text('No Image Selected',
                          style: TextStyle(color: Colors.white)),
                    )
                  : null,
            ),
            15.toHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonComponent(
                  width: 150.w,
                  title: 'Upload',
                  color: maincolor,
                  ontap: _showImagePickerOptions,
                ),
                Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return ButtonComponent(
                      width: 150.w,
                      title: 'Analyze',
                      color: maincolor,
                      isLoading: value.isLoading,
                      ontap: () {
                        if (_imageFile != null && !value.isLoading) {
                          _analyzeImage();
                        } else if (_imageFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select an image first')),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            20.toHeight,
            Expanded(
              child: analysisResult != null
                  ? ListView.builder(
                      itemCount:
                          _generateCardsFromResult(analysisResult!).length,
                      itemBuilder: (context, index) {
                        final cardData =
                            _generateCardsFromResult(analysisResult!)[index];
                        return _buildAnalysisCard(
                            cardData['title']!, cardData['content']!);
                      },
                    )
                  : const Center(
                      child: Text('Analyze an image to see results'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
