import 'dart:typed_data';

class ImageFileData {
  final String name;
  final String mime;
  final Uint8List bytes;

  const ImageFileData(
      {required this.bytes, required this.mime, required this.name});
}
