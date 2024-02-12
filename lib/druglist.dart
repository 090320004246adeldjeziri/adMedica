import 'package:flutter/material.dart';

class Drug {
  String name;
  String dosage;
  double price;

  Drug({
    required this.name,
    required this.dosage,
    required this.price,
  });
}

class DrugList extends StatelessWidget {
  final List<Drug> drugList = [
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    Drug(name: 'Aspirin', dosage: '100mg', price: 5.99),
    Drug(name: 'Paracetamol', dosage: '500mg', price: 3.49),
    // Add more drugs to the list as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pharmacy App'),
        ),
        body: ListView.builder(
          itemCount: drugList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(drugList[index].name),
              subtitle: Text(
                  '${drugList[index].dosage} - \$${drugList[index].price.toStringAsFixed(2)}'),
              // Add more information to display if needed
            );
          },
        ),
      ),
    );
  }
}
