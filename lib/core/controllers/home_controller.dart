import 'package:get/get.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var image = Rxn<File?>();
  var picker = ImagePicker().obs;
  var scannedText = ''.obs;
  var pickedFile = Rxn<XFile?>();

  Future getImage(ImageSource source) async {
    pickedFile.value = await picker.value.pickImage(source: source);

    if (pickedFile.value != null) {
      image.value = File(pickedFile.value!.path);
    } else {
      debugPrint('No Image selected');
    }

    // setState(() {});
  }

  void getRecognizedText(XFile image) async {
    scannedText.value = '';
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText.value = '$scannedText${line.text}\n';
      }
    }
  }
}
