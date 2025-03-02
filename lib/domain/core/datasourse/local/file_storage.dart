import 'dart:io';

abstract class FileStorage {
  Future<String?> saveImageToStorage(File image);
}
