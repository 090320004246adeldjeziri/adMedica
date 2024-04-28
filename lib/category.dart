import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical/controller/categoryController.dart';

import 'productCategory.dart'; 



class Category extends StatelessWidget { 

  final CategoryController categoryController = Get.put(CategoryController());

  final List<String> pharmacyCategories = [
    'Vitamin',
    'Baby',
    'Medical material',
    'Cleaning'
  ];

  Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
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
                Get.to(ProductCategory(category: category));
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 8, right: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.amber[100],
                  border: Border.all(
                    color: Colors.grey,
                    width: 2, // Adjust the border width as needed
                  ),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Colors.black,
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
