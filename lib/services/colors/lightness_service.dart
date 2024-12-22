import 'package:flutter/material.dart';

class LightnessService {
  Color changeLightness(Color color, int intensity) {
    var hsl = HSLColor.fromColor(color);

    hsl = hsl.withLightness(intensity / 100);
    return hsl.toColor();
  }

  List<Color> getPalette(Color color) {
    final palette = <Color>[];
    final tones = [10, 20, 30, 40, 50, 60, 70, 80, 90];

    for (final tone in tones) {
      palette.add(changeLightness(color, tone));
    }

    return palette;
  }
}
