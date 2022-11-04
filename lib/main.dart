import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upperlint_test/admin/adminSignin.dart';
import 'package:upperlint_test/client/splashscreen.dart';
import 'package:upperlint_test/helpers/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'helpers/sizeConfig.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: kIsWeb ? AdminSignIn() : Splash(),
              routes: routes,
            );
          },
        );
      },
    );
  }
}
