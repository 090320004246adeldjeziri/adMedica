import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medicament',
        theme: ThemeData(backgroundColor: const Color(0xFF3B4C4B)),
        home: const MyHomePage(title: ' Medical Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: Colors.green,
              onPressed: (() {}),
              splashColor: Colors.white38, // when u push it
              icon: const Icon(Icons.home),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: (() {}),
              icon: const Icon(Icons.verified_user_rounded),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: (() {}),
              icon: const Icon(Icons.search),
            ),
            IconButton(
              color: Colors.blue,
              disabledColor: Colors.black54,
              onPressed: (() {}),
              icon: const Icon(Icons.language_sharp),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[],
        ),
      ),
    );
  }
}
