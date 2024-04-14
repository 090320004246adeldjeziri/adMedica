// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var selectedIndex = 0.obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}

class Category extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  final List<String> pharmacyCategories = [
    'Default',
    'Vitamin',
    'Baby',
    'Medical material',
    'Cleaning'
  ];

  Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Obx(() {
        final selectedIndex = categoryController.selectedIndex.value;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pharmacyCategories.length,
          itemBuilder: (context, index) {
            final category = pharmacyCategories[index];
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                categoryController.selectCategory(index);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
