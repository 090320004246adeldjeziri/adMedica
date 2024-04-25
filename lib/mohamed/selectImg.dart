import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../constants/appImages.dart';
import '../constants/appbodytext.dart';
import 'img_controller.dart';
import '../widgets/buttonSelectImg.dart';
import '../widgets/customeBodyText.dart';
import '../widgets/customeImage.dart';
import '../widgets/customeTitle.dart';

class SelectImg extends StatelessWidget {
  SelectImg({Key? key, required this.title}) : super(key: key);
  final String title;

  String? imagePath;
  ImageController controller = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ImageController>(builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomeLottieImage(
                height: 260,
                path: AppImages.select,
                speed: 0.1,
              ),
              const CustomeTitle(
                title: "Select Ordonance",
                size: 40,
              ),
              CustomeBodyText(body_: AppBodyText.choosePhoto),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonSelectImg(
                    buttonIcon: Icons.photo,
                    buttonTitle: "Gallery",
                    isGallery: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonSelectImg(
                    buttonIcon: Icons.camera_alt_outlined,
                    buttonTitle: "Camera",
                    isGallery: false,
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
