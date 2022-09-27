import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/controllers/home_controller.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_drawer.dart';
import 'package:optical_character_recognizer/ui/widgets/custom_row.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    showCustomDialog() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        homeController.getImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Gallery'),
                      onTap: () {
                        Navigator.pop(context);
                        homeController.getImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    handleImageTap() async {
      showCustomDialog();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text('Add Image', style: loginTextTextStyle),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .22,
                      width: MediaQuery.of(context).size.width * 1,
                      child: homeController.image.value != null
                          ? ClipRRect(
                              child: Image.file(
                                homeController.image.value!.absolute,
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
                      if (homeController.pickedFile.value != null) {
                        homeController.getRecognizedText(
                            homeController.pickedFile.value!);
                      } else {
                        Utils.showSnackBar(context, 'Please pick a image');
                      }
                    },
                    color: homeController.scannedText.value.isEmpty
                        ? Colors.black
                        : Colors.grey,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: ListView(
                                children: [
                                  Text(homeController.scannedText.value),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
