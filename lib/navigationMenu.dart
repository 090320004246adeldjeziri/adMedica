import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical/addProduct.dart';
import 'package:medical/carteShopping.dart';
import 'package:medical/favorite.dart';
import 'package:medical/main.dart';
import 'package:medical/mohamed/partie_pharmacy/list_notification.dart';
import 'package:medical/searchBar.dart';
import 'HomePage.dart';
import 'mohamed/selectImg.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 8,
          backgroundColor: Color.fromRGBO(226, 239, 247, 1),
          //surfaceTintColor: Color(0x00ff01),
          height: 80,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          selectedIndex: controller.selectedIndex.value,
          destinations: const [
            NavigationDestination(
                icon: Icon(CupertinoIcons.home, size: 26),
                label: "Products",
                tooltip: "Home Page"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.bag,
                  size: 26,
                ),
                label: "Store"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.heart,
                  size: 26,
                ),
                label: "Favorites"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.scope,
                  size: 26,
                ),
                label: "Pharmacy"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.add_circled,
                  size: 26,
                ),
                label: "Add Product"),
                  NavigationDestination(
                icon: Icon(
                  CupertinoIcons.list_bullet,
                  size: 26,
                ),
                label: "ordonnanc"),
           
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    MyHomePage(),
    CartPage(),
    const FavoritesPage(),
    SelectImg(title: "selectionner l'ordonnance "),
    const AddProductToFirebase(),
    const ListOrdonnace(),
  
  ];
}