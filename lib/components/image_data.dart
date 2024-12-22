import 'package:extrator/data/color_data.dart';
import 'package:extrator/services/file_manager.dart';
import 'package:flutter/material.dart';

class ImageData extends StatelessWidget {
  final PaletteData? paletteData;
  final fileManager = const FileManager();
  const ImageData(this.paletteData, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: paletteData?.name);
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: paletteData != null
              ? [
                  Expanded(
                      flex: 0,
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          paletteData?.name = value;
                        },
                        style: TextStyle(fontSize: 40),
                        textAlign: TextAlign.center,
                      )),
                  // Text(
                  //   paletteData!.name,
                  //   style: TextStyle(fontSize: 40),
                  //   textAlign: TextAlign.center,
                  // ),
                  Text(
                    paletteData!.mime,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final file =
                            paletteData!.fileGenerator.createFile(paletteData!);
                        await fileManager.downloadFile(file);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("arquivo ${file.name} foi baixado")));
                      },
                      child: Text("baixar ${paletteData!.fileGenerator.name}"))
                ]
              : const [Text("sem dados")],
        ));
  }
}
