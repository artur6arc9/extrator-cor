import 'package:extrator/data/color_data.dart';
import 'package:extrator/data/palette_file.dart';
import 'package:extrator/services/palette_file/palette_file_generator.dart';
import 'package:flutter/material.dart';
import "package:extrator/extensions/hex_extension.dart";

class HexFileGenerator extends PaletteFileGenerator {
  const HexFileGenerator();

  @override
  PaletteFile createFile(PaletteData palette) {
    return PaletteFile(
        content: palette.colors
            .fold(<Color>[], (finalList, list) => [...finalList, ...list])
            .map((color) => color.toHex(leadingHashSign: false))
            .join("\n"),
        name: "${palette.name}.hex");
  }

  @override
  String get name => "Hex";
}
