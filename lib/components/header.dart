import 'dart:typed_data';
import 'package:extrator/components/image_data.dart';
import 'package:extrator/components/image_input.dart';
import 'package:extrator/constants/extract_type.dart';
import 'package:extrator/constants/palette_file_type.dart';
import 'package:extrator/data/color_data.dart';
import 'package:extrator/data/image_file_data.dart';
import 'package:extrator/data/palette_file.dart';
import 'package:extrator/services/file_manager.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Function() extractColors;
  final Function(ImageFileData image) setImage;
  final PaletteData? data;
  final ExtractType extractType;
  final Function(ExtractType type) setExtractType;
  final containerRadius = const Radius.circular(10);
  final fileManager = const FileManager();
  final PaletteFileType paletteFileType;
  final Function(PaletteFileType type) setPaletteFileType;
  const Header(
      {required this.extractColors,
      super.key,
      required this.data,
      required this.extractType,
      required this.setExtractType,
      required this.setImage,
      required this.paletteFileType,
      required this.setPaletteFileType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: ExtractType.values
                .map((type) => GestureDetector(
                      onTap: () {
                        setExtractType(type);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xff3a2c39),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(10))),
                        child: Text(
                          type.name,
                          style: TextStyle(
                              color: extractType == type
                                  ? Colors.purple
                                  : Colors.white),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color(0xff3a2c39),
                  borderRadius: BorderRadius.only(
                      topLeft: containerRadius, bottomRight: containerRadius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageInput(image: data?.image, setImage: setImage),
                  ImageData(data)
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: PaletteFileType.values
                .map((type) => GestureDetector(
                      onTap: () {
                        setPaletteFileType(type);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                            color: Color(0xff3a2c39),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          type.generator.name,
                          style: TextStyle(
                              color: paletteFileType == type
                                  ? Colors.purple
                                  : Colors.white),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ]));
  }
}
