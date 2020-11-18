import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
  final _controller = TextEditingController();
  final _fname = 'mydata.txt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Text(
            'Home Screen',
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          TextField(
            controller: _controller,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            title: Text('Save'),
            icon: Icon(Icons.save),
          ),
          BottomNavigationBarItem(
            title: Text('Load'),
            icon: Icon(Icons.open_in_new),
          ),
        ],
        onTap: (int value) {
          switch (value) {
            case 0:
              saveIt(_controller.text);
              setState(() {
                _controller.text = '';
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Saved!'),
                        content: Text("Save message from file."),
                      ));
              break;
            case 1:
              setState(() {
                loadIt().then((String value) {
                  setState(() {
                    _controller.text = value;
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text('Loaded!'),
                            content: Text('Load message from file.'),
                          ));
                });
              });
              break;
            default:
              print('no default.');
          }
        },
      ),
    );
  }

  Future<File> getDataFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File(directory.path + '/' + filename);
  }

  void saveIt(String value) async {
    getDataFile(_fname).then((File file) {
      file.writeAsString(value);
    });
  }

  Future<String> loadIt() async {
    try {
      final file = await getDataFile(_fname);
      return file.readAsString();
    } catch (e) {
      return null;
    }
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
