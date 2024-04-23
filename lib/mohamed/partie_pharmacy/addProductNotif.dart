import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/News.dart';
import 'package:medical/mohamed/iconNotif.dart';
import 'package:medical/mohamed/partie_pharmacy/iconNotifPharma.dart';


class AddProductNotif extends StatefulWidget {
  const AddProductNotif({Key? key}) : super(key: key);

  @override
  State<AddProductNotif> createState() => _AddProductNotifState();
}

class _AddProductNotifState extends State<AddProductNotif> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imageList = [];
  final List<String> _imageUrlList = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categoryOptions = [
    'Baby',
    'Vitamin',
    'Medical material',
    'cleaning'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  title: Text(
    'Add New Product2',
    style: GoogleFonts.lexend(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
  actions: [
    IconButton(
      icon: NotificationIconPharma(),
      onPressed: () {
        // Ajoutez votre logique onPressed ici
      },
    ),
  ],
  centerTitle: true,
  backgroundColor: Colors.grey.withOpacity(0.08),
  toolbarHeight: 70,
  elevation: 0,
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildTextField(
              labelText: 'Seller',
              hintText: 'Enter Pharmacy name',
              controller: _sellerController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Product',
              hintText: 'Enter product name',
              controller: _titleController,
            ),
            const SizedBox(height: 16),
            _buildCategoryDropdown(),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Quantity',
              hintText: 'Enter product quantity',
              controller: _quantityController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Description',
              hintText: 'Enter product description',
              maxLines: 4,
              controller: _descriptionController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Price',
              hintText: 'Enter product price',
              controller: _priceController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Place',
              hintText: 'Enter product location',
              controller: _placeController,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              controller: _numberController,
            ),
            const SizedBox(height: 20),
            _buildImageGrid(),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: GoogleFonts.lexend(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          items: _categoryOptions.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Select category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          style: GoogleFonts.lexend(fontSize: 14, color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add product images',
          style: GoogleFonts.lexend(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: _imageList.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.file(File(_imageList[index].path));
          },
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickImages,
          icon: const Icon(Icons.add_photo_alternate),
          label: const Text('Add Images'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _submitForm,
        icon: const Icon(Icons.send),
        label: const Text('Submit Request'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          primary: Colors.green,
        ),
      ),
    );
  }

  void _pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _imageList.addAll(pickedImages);
      });
    }
  }

  Future<void> _uploadImages() async {
    for (final imageFile in _imageList) {
      final file = File(imageFile.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      _imageUrlList.add(downloadUrl);
    }
  }

  Future<void> _submitForm() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _selectedCategory == null ||
        _numberController.text.isEmpty ||
        _placeController.text.isEmpty ||
        _imageList.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all the fields and add at least one image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    await _uploadImages();

    final cabItem = CabItem(
      prix: _priceController.text,
      productName: _titleController.text,
      imgUrl: _imageUrlList,
      description: _descriptionController.text,
      quantity: _quantityController.text,
      category: _selectedCategory!,
      seller: _sellerController.text,
      place: _placeController.text,
      number: _numberController.text,
    );

    try {
      await cabItem.sendToFirestore();
      fetchDataFromFirestore();
      clearForm();
      Fluttertoast.showToast(
        msg: "Product has been submitted to the admin",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: "An error occurred",
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
    _categoryOptions.clear();
    _quantityController.clear();
    _imageList.clear();
    _numberController.clear();
    _placeController.clear();
    _sellerController.clear();
    _imageUrlList.clear();
    _selectedCategory = null;

    setState(() {});
  }
}
