import 'package:extrator/data/color_data.dart';
import 'package:extrator/data/palette_file.dart';
import 'package:extrator/services/palette_file/palette_file_generator.dart';
import 'package:flutter/material.dart';

class GplFileGenerator extends PaletteFileGenerator {
  const GplFileGenerator();
  @override
  PaletteFile createFile(PaletteData palette) {
    final colors = palette.colors
        .fold(<Color>[], (finalList, list) => [...finalList, ...list]);
    return PaletteFile(
        content: """
        GIMP Palette
        #Palette Name: ${palette.name}
        #Colors: ${colors.length}
        ${colors.map((color) => "${color.red} ${color.green} ${color.blue} unnamed").join("\n")}""",
        name: "${palette.name}.gpl");
  }

  @override
  String get name => "gimp gpl";
}
