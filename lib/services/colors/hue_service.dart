import 'dart:math';

import 'package:extrator/constants/color_group.dart';
import 'package:extrator/data/color_type.dart';
import 'package:extrator/services/colors/lightness_service.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class HueService {
  final lightnessService = LightnessService();
  ColorType getTypeOf(Color color) {
    final hsl = HSLColor.fromColor(color);
    final group = ColorGroup.values.firstWhereOrNull((group) =>
            (group.hueStart <= hsl.hue && group.hueEnd > hsl.hue) &&
            (group.lighnessStart <= hsl.lightness &&
                group.lighnessEnd > hsl.lightness) &&
            (group.saturationStart <= hsl.saturation &&
                group.saturationEnd > hsl.saturation)) ??
        ColorGroup.red;

    return ColorType(color: color, group: group);
  }

  double getDifference(Color color1, Color color2) {
    final c1 = lightnessService.changeLightness(color1, 50);
    final c2 = lightnessService.changeLightness(color2, 50);
    return sqrt((c2.red - c1.red) ^
            2 + (c2.green - c1.green) ^
            2 + (c2.blue - c1.blue)) /
        sqrt((255) ^ 2 + (255) ^ 2 + (255) ^ 2);
  }
}
