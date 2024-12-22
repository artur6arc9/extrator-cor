import 'dart:typed_data';

import 'package:extrator/services/palette_file/palette_file_generator.dart';
import 'package:flutter/material.dart';

class PaletteData {
  Uint8List image;
  String name;
  String mime;
  List<List<Color>> colors;
  PaletteFileGenerator fileGenerator;
  // final List<List<Color>> all;
  // final List<List<Color>> dominant;
  // final List<List<Color>> populars;
  // final List<List<Color>> differents;
  // final List<List<Color>> type;

  PaletteData(
      {required this.image,
      required this.mime,
      required this.fileGenerator,
      required this.name,
      required this.colors});
}
