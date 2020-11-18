import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      initialRoute: '/',
      routes: {
        '/second': (context) => SecondScreen('Second'),
        '/third': (context) => SecondScreen('Third'),
      },
      home: new FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => new _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Next'),
            icon: Icon(Icons.navigate_next),
          ),
        ],
        onTap: (int value) {
          if (value == 1)
            Navigator.pushNamed(
              context,
              '/second',
            );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String _value;

  SecondScreen(this._value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next'),
      ),
      body: Center(
        child: Text(
          '"$_value" Screen',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            title: Text('prev'),
            icon: Icon(Icons.navigate_before),
          ),
          BottomNavigationBarItem(
            title: Text('?'),
            icon: Icon(Icons.android),
          ),
        ],
        onTap: (int value) {
          if (value == 0) Navigator.pop(context);
          if (value == 1) Navigator.pushNamed(context, '/third');
        },
      ),
    );
  }
}
