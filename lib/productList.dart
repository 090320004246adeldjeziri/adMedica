import 'package:flutter/material.dart';
import 'package:medical/News.dart';
import 'package:get/get.dart';

import 'controller/ProductController.dart';
// Import News.dart if it's needed for news functionality
// import 'News.dart';

class CategoryController extends GetxController {
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void selectCategory(int index) {
    _selectedIndex.value = index;
  }
}
class Category extends StatelessWidget {
  Category({Key? key}) : super(key: key);

  final List<String> pharmacyCategories = [
    'All Product',
    'Vitamin',
    'Baby',
    'Medical material',
    'Cleaning',
  ];

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pharmacyCategories.length,
          itemBuilder: (context, index) {
            final isSelected = categoryController.selectedIndex == index;
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
                  pharmacyCategories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class ListProduct extends StatelessWidget {
  ListProduct({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(),
        Obx(
          () {
            final selectedIndex = categoryController.selectedIndex;
            List<CabItem> filteredProducts;

            if (selectedIndex == 0) {
              filteredProducts = ProductController().products;
            } else {
              filteredProducts = ProductController().products
                  .where((product) =>
                      product.category ==
                      Category().pharmacyCategories[selectedIndex])
                  .toList();
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 0.8,
                  margin: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.indigoAccent),
                    child: Text(product.productName),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}