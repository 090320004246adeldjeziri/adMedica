import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:medical/client/SettingPage.dart';
import 'package:medical/doctor/doctor/screen/doctorList.dart';
import 'package:medical/partie_pharmacy/addProductNotif.dart';
import 'package:medical/partie_pharmacy/list_notification.dart';
import 'package:medical/partie_pharmacy/list_pharmacy4.dart';

import 'iconNotifPharma.dart';
import 'list_notification2.dart';

class PharmacyMenu extends StatelessWidget {
  const PharmacyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 8,
          backgroundColor: const Color.fromRGBO(226, 239, 247, 1),
          //surfaceTintColor: Color(0x00ff01),
          height: 80,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          selectedIndex: controller.selectedIndex.value,
          destinations: const [
            NavigationDestination(
                icon: Icon(CupertinoIcons.home, size: 26),
                label: "Prescriptions",
                tooltip: "Home Page"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.add_circled,
                  size: 26,
                ),
                label: "Add Product"),
               
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Setting",
            )
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [ Notif(), const AddProductNotif(), Setting()];
}
