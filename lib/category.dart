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

  final List<Map<String, String>> pharmacyCategories = [
    {'name': 'Default'},
    {
      'name': 'Over-the-Counter',
      'description': 'Non-prescription drugs for minor ailments.',
    },
    {
      'name': 'Prescription Medications',
      'description': 'Drugs requiring a doctor\'s prescription.',
    },
    {
      'name': 'Herbal and Natural Remedies',
      'description': 'Products from natural sources.',
    },
    {
      'name': 'First Aid Supplies',
      'description': 'Items for emergency medical assistance.',
    },
    {
      'name': 'Vitamins and Supplements',
      'description': 'Nutritional supplements.',
    },
    {
      'name': 'Personal Care Products',
      'description': 'Hygiene and grooming items.',
    },
    {
      'name': 'Baby and Infant Care',
      'description': 'Products for infant health and well-being.',
    },
    {
      'name': 'Medical Devices and Equipment',
      'description': 'Tools for health monitoring and treatment.',
    },
    {
      'name': 'Home Health Care Aids',
      'description': 'Products for home-based healthcare needs.',
    },
    {
      'name': 'Health and Wellness Products',
      'description': 'Items for overall well-being.',
    },
  ];

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
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                child: Text(
                  category['name']!,
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
