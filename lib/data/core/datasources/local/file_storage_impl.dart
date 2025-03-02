import 'dart:io';
import 'package:go_work/domain/core/datasourse/local/file_storage.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageImpl implements FileStorage {
  @override
  Future<String?> saveImageToStorage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImage = await image.copy('$path/$fileName');
    return savedImage.path;
  }
}
