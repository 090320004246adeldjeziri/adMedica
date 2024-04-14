// ignore_for_file: must_be_immutable, unused_import, prefer_const_constructors_in_immutables, dead_code, file_names

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;

import '../mohamed/img_controller.dart';
import '../mohamed/listPharma.dart';
import '../mohamed/selectImg.dart';
import '../services/imagesService.dart';

class ButtonSelectImg extends StatelessWidget {
  static ImageController controller = Get.put(ImageController());
  final String buttonTitle;
  final IconData? buttonIcon;
  final bool isGallery;

  ButtonSelectImg({
    Key? key,
    required this.buttonTitle,
    required this.buttonIcon,
    this.isGallery = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ImageController>(
        builder: (controller) {
          return Container(
            height: 50,
            width: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(100),
                right: Radius.circular(100),
              ),
            ),
            child: ElevatedButton(
              onPressed: () async {
                ImageService.selectedImagePath = await controller.afficheImage(
                  isGallery ? ImageSource.gallery : ImageSource.camera,
                );

                if (ImageService.selectedImagePath != null) {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildImagePreview(
                          context, ImageService.selectedImagePath);
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(buttonIcon),
                  Text(buttonTitle),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context, String? selectedImagePath) {
    return
        // PharmacyListScreen ();
        IntrinsicHeight(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme l'écran
              },
            ),
          ),
          Expanded(
            child: IntrinsicHeight(
              child: Image.file(File(ImageService.selectedImagePath!)),
            ),
          ),
          ElevatedButton(
            child: const Text('choisir les pharmacy'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PharmacyListScreen(),
                ),
              );
            },
          )
          // _handleSendImage(context, selectedImagePath);
          //je veux ici affiche la liste des pharmacy et apres send image
        ],
      ),
    );
  }
}
