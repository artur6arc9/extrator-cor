import 'dart:io';
import 'dart:typed_data';

import 'package:extrator/constants/extract_type.dart';
import 'package:extrator/data/color_type.dart';
import 'package:extrator/services/colors/extract_service.dart';
import 'package:extrator/services/colors/hue_service.dart';
import 'package:extrator/services/colors/lightness_service.dart';
import 'package:flutter/material.dart';

class ColorService {
  final extractService = ExtractService();
  final lightnessService = LightnessService();
  final hueService = HueService();

  Future<List<Color>> getDominantPalette(Uint8List image) async {
    final dominantColor = await extractService.getDominantColor(image);

    return lightnessService.getPalette(dominantColor!);
  }

  Future<List<List<Color>>> getSingleTypePalette(Uint8List image) async {
    final colors = await extractService.getColors(image);

    return colors
        .fold(<ColorType>[], (list, color) {
          final type = hueService.getTypeOf(color);
          debugPrint(list.map((i) => i.group).toString());
          if (!list.any((item) => type.group == item.group)) {
            list.add(type);
          }
          return list;
        })
        .map((color) => lightnessService.getPalette(color.color))
        .toList();
  }

  Future<List<List<Color>>> getByType(ExtractType type, Uint8List image) async {
    switch (type) {
      case ExtractType.dominant:
        final palette = await getDominantPalette(image);
        return [palette];
      case ExtractType.all:
        final colors = await extractService.getColors(image);
        return [colors];
      // case ExtractType.differents:
      //   return getDifferentColors(image);
      case ExtractType.populars:
        return getPopularPalette(image);
      case ExtractType.type:
        return getSingleTypePalette(image);
    }
  }

  Future<List<List<Color>>> getDifferentColors(Uint8List image) async {
    final colors = await extractService.getColors(image);

    return colors
        .map((color) => lightnessService.changeLightness(color, 50))
        .fold(<Color>[], (accumulation, color) {
          debugPrint(accumulation
              .every((e) => hueService.getDifference(e, color) > 0.5)
              .toString());
          if (accumulation
              .every((e) => hueService.getDifference(e, color) > 0.7)) {
            accumulation.add(color);
          }
          return accumulation;
        })
        .map((color) => lightnessService.getPalette(color))
        .toList();
  }

  Future<List<List<Color>>> getPopularPalette(Uint8List image) async {
    final colors = await extractService.getPopularColors(image);

    return colors.map((color) => lightnessService.getPalette(color)).toList();
  }
}
