import 'package:flutter/material.dart';
import 'add_breakdown.dart';
// first commit
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tickle',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: const Color(0xFFFFCAAF),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1), fontWeight: FontWeight.bold)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFCAAF),
          elevation: 0,
        ),
      ),
      home: const MyHomePage(title: 'Tickle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>AddBreakdown()));
            }, 
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
              
          ],
        ),
      ),
    );
  }
}
