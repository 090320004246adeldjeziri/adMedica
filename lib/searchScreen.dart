import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'News.dart';

class SearchScreen extends StatefulWidget {
  final List<CabItem> products;

  const SearchScreen({Key? key, required this.products}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CabItem> filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = widget.products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.seller.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(226, 239, 247, 1), // Light blue color
          toolbarHeight: MediaQuery.of(context).size.height *
              0.065, // 6.5% of screen height
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
              size: 28,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 2.0, top: 8, bottom: 8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.05, // 5% of screen height
                child: TextField(
                  enableSuggestions: true,
                  textAlign: TextAlign.left,
                  controller: _searchController,
                  onChanged: _filterProducts,
                  decoration: InputDecoration(
                    hintText: 'Find Your Product !',
                    contentPadding: EdgeInsets.fromLTRB(48, 5, 24, 14),
                    hintStyle: GoogleFonts.lexend(
                      color: Colors.green,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    prefixIconColor: Colors.green,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: filteredProducts.isNotEmpty
            ? ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                product.imgUrl[0],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    product.prix,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          product.description,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Seller: ${product.seller}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No products found',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
      ),
    );
  }
}
