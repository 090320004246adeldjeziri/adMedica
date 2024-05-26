
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical/mohamed/nouv_ist_pharma.dart';
import 'package:path/path.dart' as path;
import 'package:lottie/lottie.dart';
import '../mohamed/img_controller.dart';
import '../mohamed/listPharma.dart';
import '../mohamed/selectImg.dart';
import '../services/imagesService.dart';
import '../constants/appImages.dart';

class ButtonSelectImg extends StatelessWidget {
  static ImageController controller = Get.put(ImageController());
  final String buttonTitle;
  final IconData buttonIcon;
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade400,
                  Colors.green.shade600,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
              ),
              onPressed: () async {
                ImageService.selectedImagePath = await controller.afficheImage(
                  isGallery ? ImageSource.gallery : ImageSource.camera,
                );
                if (ImageService.selectedImagePath != null) {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return _buildImagePreview(context, ImageService.selectedImagePath);
                    },
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    buttonIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    buttonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context, String? selectedImagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(ImageService.selectedImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ElevatedButton(
              child: const Text('Choisir les pharmacies'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    // PharmacyListScreen()
                      LIstPharma2()
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}