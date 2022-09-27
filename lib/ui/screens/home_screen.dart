import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_drawer.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_row.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String scannedText = '';
  XFile? pickedFile;

  Future getImage(ImageSource source) async {
    pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile!.path);
    } else {
      debugPrint('No Image selected');
    }

    setState(() {});
  }

  handleImageTap() async {
    showCustomDialog();
  }

  showCustomDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getRecognizedText(XFile image) async {
    scannedText = '';
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = '$scannedText${line.text}\n';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                const Text('Add Image', style: loginTextTextStyle),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * .22,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _image != null
                          ? ClipRRect(
                              child: Image.file(
                                _image!.absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              width: 100,
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 35,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Take Images from Camera and gallery',
                  style: loginTextSmallTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                CustomRow(
                  text: 'Add Image',
                  icon: Icons.camera_alt,
                  onPress: handleImageTap,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                CustomRow(
                  text: 'Scan Text',
                  icon: Icons.qr_code_scanner_outlined,
                  onPress: () {
                    if (pickedFile != null) {
                      getRecognizedText(pickedFile!);
                    } else {
                      Utils.showSnackBar(context, 'Please pick a image');
                    }
                  },
                  color: scannedText.isEmpty ? Colors.black : Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .26,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            children: const [
                              Text(
                                'Text',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              children: [
                                Text(scannedText),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
