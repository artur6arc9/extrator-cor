import 'package:extrator/data/color_data.dart';
import 'package:extrator/data/palette_file.dart';
import 'package:flutter/material.dart';

abstract class PaletteFileGenerator {
  const PaletteFileGenerator();
  String get name;
  PaletteFile createFile(PaletteData palette);
}
