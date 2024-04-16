import 'package:flutter/material.dart';
import 'package:medical/News.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SliderController());

    // Calculate the width based on the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth - 10; // Adjust padding and margins

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: products.length,
            options: CarouselOptions(
              viewportFraction: 1,
              height: 180,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlay: true,
              onPageChanged: (index, _) => controller.updateIndex(index),
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(products[index].imgUrl.first),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < products.length; i++)
                  Container(
                    height: 7,
                    width: 18,
                    margin: const EdgeInsets.only(top: 10, left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: controller.carouselCurrentIndex.value == i
                          ? Colors.green
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SliderController extends GetxController {
  static SliderController get instance => Get.find();
  final carouselCurrentIndex = 0.obs;
  void updateIndex(int index) {
    carouselCurrentIndex.value = index;
  }
}
