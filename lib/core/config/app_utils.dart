import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static int? validateInt(String? value) {
    if (value == null || int.tryParse(value) == null) {
      return null;
    }
    return int.parse(value);
  }

  static bool? validateBool(String? value) {
    if (value == null) return null;
    final lowerValue = value.toLowerCase();
    if (lowerValue == 'true' || lowerValue == '1') return true;
    if (lowerValue == 'false' || lowerValue == '0') return false;
    return null;
  }

  static Future<File?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return picked;
  }

  static String dateFormat(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
