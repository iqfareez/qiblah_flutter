import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import 'screens/qibla_compass.dart';

// Brand color.
const _brandTeal = Color(0xFF00897B);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with DynamicColorBuilder
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          lightColorScheme = lightColorScheme.copyWith(secondary: _brandTeal);

          darkColorScheme = darkDynamic.harmonized();
          darkColorScheme = darkColorScheme.copyWith(secondary: _brandTeal);
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: _brandTeal);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: _brandTeal,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'Qiblah',
          theme: ThemeData(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          themeMode: ThemeMode.system,
          home: Scaffold(
            body: FutureBuilder(
              future: FlutterQiblah.androidDeviceSensorSupport(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                }

                return const QiblaCompass();
              },
            ),
          ),
        );
      },
    );
  }
}
