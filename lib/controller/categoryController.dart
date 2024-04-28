import "package:get/get.dart";

class CategoryController extends GetxController {
  var selectedIndex = 0.obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}
