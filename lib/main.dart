import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'screens/qibla_compass.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiblah',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark().copyWith(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: FutureBuilder(
          future: _deviceSupport,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return SpinKitCubeGrid(
                duration: Duration(milliseconds: 670),
              );
            if (snapshot.hasError)
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            if (snapshot.hasData)
              return QiblaCompass();
            else
              return Container(
                child: Text('Error'),
              );
          },
        ),
      ),
    );
  }
}
