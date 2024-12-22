import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:extrator/data/image_file_data.dart';
import 'package:extrator/data/palette_file.dart';
import "package:file_picker/file_picker.dart";
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class FileManager {
  const FileManager();
  FutureOr<ImageFileData?> getOneImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final file = result.files.single;
      return ImageFileData(
          bytes: file.bytes!,
          mime:
              file.extension != null ? "image/${file.extension}" : "image/png",
          name: file.name.substring(0, file.name.lastIndexOf(".")));
    } else {
      return null;
    }
  }

  Future<void> downloadFile(PaletteFile file) async {
    await FileSaver.instance.saveFile(
      name: file.name,
      bytes: Uint8List.fromList(file.content.codeUnits),
    );
  }
}
