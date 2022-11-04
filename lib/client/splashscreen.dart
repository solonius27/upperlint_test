import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:upperlint_test/client/applypage.dart';
import 'package:upperlint_test/helpers/cus_widgets.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //const Splash({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/9757-welcome.json',
              repeat: true,
              // width: calculateSize(200),
              // height: calculateSize(200),
            ),
            GestureDetector(
              onTap: checkifclosed,
              child: appText("Apply", 24, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkifclosed() async {
    var count;

    final db = await FirebaseFirestore.instance.collection('users').get().then(
      (res) {
        count = res.size;
        print(res.size);
      },
      onError: (e) => print("Error completing: $e"),
    );

    if (count < 4) {
      navigate(context, Apply.routeName);
    } else {
      showmessage(context, "Application closed");
    }
  }
}
