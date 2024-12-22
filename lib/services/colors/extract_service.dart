import "dart:io";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:palette_generator/palette_generator.dart";

class ExtractService {
  Future<PaletteGenerator> _getPalette(Uint8List file) async {
    final palette = await PaletteGenerator.fromImageProvider(MemoryImage(file));
    return palette;
  }

  Future<List<Color>> getPopularColors(Uint8List image) async {
    final palette = await _getPalette(image);
    final total = palette.paletteColors.fold(0, (accumulation, current) {
      accumulation += current.population;
      return accumulation;
    });
    return palette.paletteColors
        .where((color) => color.population / total > 0.1)
        .map((color) => color.color)
        .toList();
  }

  Future<List<Color>> getColors(Uint8List file) async {
    final palette = await _getPalette(file);

    return palette.colors.toList();
  }

  Future<Color?> getDominantColor(Uint8List file) async {
    final palette = await _getPalette(file);

    return palette.dominantColor?.color;
  }
}
