import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:extrator/data/image_file_data.dart';
import 'package:extrator/services/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ImageInput extends StatefulWidget {
  final Uint8List? image;
  final Function(ImageFileData image) setImage;

  const ImageInput({required this.image, required this.setImage, super.key});
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<ImageInput> {
  final fileManager = const FileManager();
  var isHover = false;
  late DropzoneViewController controller;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        strokeWidth: 3,
        color: Colors.white,
        child: GestureDetector(
            onTap: () async {
              final image = await fileManager.getOneImage();

              if (image != null) widget.setImage(image);
            },
            child: Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: MediaQuery.sizeOf(context).width * 0.25,
                decoration: BoxDecoration(
                  image: widget.image != null
                      ? DecorationImage(
                          opacity: isHover ? 0.5 : 1,
                          image: MemoryImage(widget.image!),
                          fit: BoxFit.fill)
                      : null,
                  color: isHover ? Colors.white30 : Colors.white70,
                ),
                child: Stack(alignment: Alignment.center, children: [
                  DropzoneView(
                    mime: const [
                      "image/jpg",
                      "image/png",
                      "image/jpeg",
                      "image/webp"
                    ],
                    onCreated: (controller) => this.controller = controller,

                    onHover: () {
                      setState(() {
                        isHover = true;
                      });
                    },
                    onLeave: () {
                      setState(() {
                        isHover = false;
                      });
                    },
                    //mime: ["image/*"],

                    onDropFile: (DropzoneFileInterface file) async {
                      debugPrint(file.name);
                      final image = await controller.getFileData(file);
                      setState(() {
                        isHover = false;
                      });
                      widget.setImage(ImageFileData(
                          bytes: image,
                          mime: file.type,
                          name: file.name
                              .substring(0, file.name.lastIndexOf("."))));
                    },
                  ),
                  widget.image == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cloud_download,
                              color: Colors.purple,
                              size: 50,
                            ),
                            Text(
                              "arraste uma imagem ou clique aqui",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : const SizedBox.shrink()
                ]))));
  }
}
