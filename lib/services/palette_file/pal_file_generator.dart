import 'package:extrator/data/color_data.dart';
import 'package:extrator/data/palette_file.dart';
import 'package:extrator/services/palette_file/palette_file_generator.dart';
import 'package:flutter/material.dart';

class PalFileGenerator extends PaletteFileGenerator {
  const PalFileGenerator();
  @override
  PaletteFile createFile(PaletteData palette) {
    final colors = palette.colors
        .fold(<Color>[], (finalList, list) => [...finalList, ...list]);
    return PaletteFile(
        content: """
JASC-PAL
0100
${colors.length}
${colors.map((color) => "${color.red} ${color.green} ${color.blue}").join("\n")}""",
        name: "${palette.name}.pal");
  }

  @override
  String get name => "jasc pal";
}
