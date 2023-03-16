import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(dynamic bytes, String fileName) async {
  Directory directory = await getApplicationSupportDirectory();
  String path = directory.path;
  File file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
