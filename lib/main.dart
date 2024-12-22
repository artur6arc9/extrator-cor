import 'package:extrator/components/header.dart';
import 'package:extrator/components/palette_grid.dart';
import 'package:extrator/constants/extract_type.dart';
import 'package:extrator/constants/palette_file_type.dart';
import 'package:extrator/data/color_data.dart';
import 'package:extrator/services/colors/color_service.dart';
import 'package:extrator/services/file_manager.dart';
import 'package:extrator/services/palette_file/gpl_file_generator.dart';
import 'package:extrator/services/palette_file/hex_file_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            surfaceTint: Colors.white,
            onSurface: Colors.white,
            seedColor: Colors.deepPurple,
            surface: const Color(0xff1d161c),
            inverseSurface: Colors.purple),
        useMaterial3: true,
      ),
      home: const Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  PaletteData? palette;
  String? name;
  var isHover = false;
  final colorService = ColorService();
  late DropzoneViewController controller;
  final fileManager = const FileManager();

  ExtractType extractType = ExtractType.type;
  PaletteFileType paletteFileType = PaletteFileType.pal;
  extractColors() async {
    if (palette != null) {
      final palettes =
          await colorService.getByType(extractType, palette!.image);

      setState(() {
        palette!.colors = palettes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 30),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Header(
                  data: palette,
                  extractType: extractType,
                  paletteFileType: paletteFileType,
                  setPaletteFileType: (type) {
                    setState(() {
                      paletteFileType = type;
                      palette?.fileGenerator = paletteFileType.generator;
                    });
                  },
                  setExtractType: (type) {
                    setState(() {
                      extractType = type;
                    });
                    extractColors();
                  },
                  extractColors: extractColors,
                  setImage: (image) {
                    setState(() {
                      if (palette != null) {
                        palette!.image = image.bytes;

                        palette!.mime = image.mime;
                      } else {
                        palette = PaletteData(
                            image: image.bytes,
                            mime: image.mime,
                            fileGenerator: paletteFileType.generator,
                            name: image.name,
                            colors: []);
                      }
                    });
                    extractColors();
                  }),
              const SizedBox(
                height: 50,
              ),
              palette != null
                  ? PaletteGrid(palette!.colors)
                  : const SizedBox.shrink()
            ]),
      )),
    );
  }
}
