import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    var x = "Setting";
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.3),
      appBar: AppBar(
        title: Text(x),
        shadowColor: Colors.red,
        elevation: 0.2,
        centerTitle: true,
      ),
      body: Center(
          child: Text('Setting Page',
              style: Theme.of(context).textTheme.headline4)),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop,
          child: Icon(Icons.expand_circle_down_outlined)),
    );
  }
}
