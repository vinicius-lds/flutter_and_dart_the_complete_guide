import 'package:_02_assignment/custom_text.dart';
import 'package:_02_assignment/text_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String appBarText = 'Default text';

  void _changeTitle() {
    setState(() {
      appBarText = 'Changed title';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                CustomText(
                  text: appBarText,
                ),
                TextControl(
                  onPressed: _changeTitle,
                )
              ],
            ),
          )),
    );
  }
}
