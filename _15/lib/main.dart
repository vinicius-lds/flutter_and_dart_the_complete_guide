import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _betteryLevel = 0;

  Future<void> _getbetteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/bettery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() => _betteryLevel = batteryLevel);
    } on PlatformException catch (error) {
      setState(() => _betteryLevel = 0);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('bettery level: $_betteryLevel'),
          ],
        ),
      ),
    );
  }
}
