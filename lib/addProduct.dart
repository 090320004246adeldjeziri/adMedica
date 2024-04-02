import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/itemList.dart';
import 'package:dropdown_button2/src/dropdown_button2.dart';
import 'package:medical/News.dart';

import 'navigationMenu.dart'; // Import your CabItem class

class AddProductToFirebase extends StatefulWidget {
  const AddProductToFirebase({Key? key}) : super(key: key);

  @override
  State<AddProductToFirebase> createState() => _AddProductToFirebaseState();
}

class _AddProductToFirebaseState extends State<AddProductToFirebase> {
  late final ImagePicker _picker;
  late final List<XFile> _imageList;
  final List<String> imageUrlList = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
   final TextEditingController _placeController = TextEditingController();
    final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _imageList = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add New Product',
            style: GoogleFonts.lexend(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () {
              Get.to(NavigationMenu()); // Corrected spelling to 'MyDashboard'
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent.withOpacity(0.01),
          elevation: 0.5,
          leadingWidth: 70,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _buildTextField(
                        labelText: 'Seller',
                        hintText: 'Write your name!',
                        controller: _sellerController),
                    _buildTextField(
                        labelText: 'Product',
                        hintText: 'Write Product Name!',
                        controller: _titleController),
                    _buildTextField(
                        labelText: 'Category',
                        hintText: 'Write Product Category!',
                        controller: _categoryController),
                    _buildTextField(
                        labelText: 'Quantity Product',
                        hintText: 'Write Product Quantity!',
                        controller: _quantityController),
                    _buildTextField(
                        labelText: 'Product Description',
                        hintText: 'Write Product Description!',
                        maxLines: 4,
                        controller: _descriptionController),
                    _buildTextField(
                        labelText: 'Price of Product',
                        hintText: 'Price of one piece!',
                        controller: _priceController),
                    _buildTextField(
                        labelText: 'Place',
                        hintText: 'Write Place of product!',
                        controller: _placeController),
                    _buildTextField(
                        labelText: 'Number Phone',
                        hintText: 'Write your name!',
                        controller: _numberController),
                    const SizedBox(height: 10),
                    _buildImageGrid(),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      onPressed: _selectImage,
                      tooltip: 'Choose an image',
                      heroTag: 'imagePickerButton',
                      child: const Icon(Icons.add_a_photo),
                    ),
                    const SizedBox(height: 10),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextField(
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            style: GoogleFonts.lexend(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ajouter images de cabine',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _imageList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Image.file(File(_imageList[index].path));
            },
          ),
        ),
      ],
    );
  }

  void _selectImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selected != null && selected.path.isNotEmpty) {
      setState(() {
        _imageList.add(selected);
      });
    }
  }

  Widget _buildSubmitButton() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: FloatingActionButton.extended(
          onPressed: _submitForm,
          label: const Text('Envoyerla demande'),
          icon: const Icon(Icons.send),
          heroTag: 'sendButton',
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _numberController.text.isEmpty ||
        _placeController.text.isEmpty ||
        _imageList.isEmpty) {
      Fluttertoast.showToast(
        msg: "Veuillez remplir tous les champs et ajouter une image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Fluttertoast.showToast(
      msg: "Votre Demande est envoyée",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    imageUrlList.clear();

    for (XFile imageFile in _imageList) {
      File file = File(imageFile.path);
      await _uploadImg(file);
    }

    // Create a CabItem instance
    CabItem cabItem = CabItem(
      prix: _priceController.text,
      productName: _titleController.text,
      imgUrl: imageUrlList,
      description: _descriptionController.text,
      quantity: _quantityController.text,
      category: _categoryController.text,
      seller: _sellerController.text,
      place: _placeController.text, // Add your place here
      number: _numberController.text, // Add your number here
    );

    try {
      await cabItem.sendToFirestore(); // Send the CabItem to Firestore
      fetchDataFromFirestore(); // Update the list of CabItems
      clearForm();
      Fluttertoast.showToast(
        msg: "Le produit a été envoyé à l'administrateur",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Une erreur s'est produite",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(error);
    }
  }

  void clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _categoryController.clear();
    _quantityController.clear();
    _imageList.clear();
    setState(() {});
  }

  Future<void> _uploadImg(File file) async {
    String fileUploadName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference ref =
        FirebaseStorage.instance.ref().child('').child(fileUploadName);
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.snapshotEvents.listen((event) {
      print('${event.bytesTransferred}\t${event.totalBytes}');
    });
    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      imageUrlList.add(uploadPath);
    });
  }
}
