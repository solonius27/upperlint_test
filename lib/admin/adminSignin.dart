import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helpers/cus_widgets.dart';

class AdminSignIn extends StatefulWidget {
  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  //const AdminSignIn({super.key});
  final username = TextEditingController();
  final pass = TextEditingController();

  bool isloading = false;

  @override
  void dispose() {
    username.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(
          0xffedfaff,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/images/Group-965.png"),
            ),
            Center(
              child: Container(
                //height: calculateSize(600),
                width: calculateSize(700),
                padding: EdgeInsets.symmetric(
                    vertical: calculateSize(100),
                    horizontal: calculateSize(85)),
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: circularRadius(20.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    appText(
                      "Upperlink Digital",
                      32,
                      weight: FontWeight.w600,
                      color: Color(0xff0D0E10),
                    ),
                    appText(
                      "Solution",
                      16,
                      weight: FontWeight.w700,
                      color: Color(0xff0D0E10),
                    ),
                    verticalSpace(53.0),
                    appText("Enter your details and sign in", 26,
                        weight: FontWeight.w500, bottommargin: 50.0),
                    AppTextFieldWidget(
                      controller: username,
                      labelText: "Username",
                    ),
                    AppTextFieldWidget(
                      labelText: "Password",
                      controller: pass,
                    ),
                    verticalSpace(20.0),
                    appButton(dologin, "Sign in", isloading: isloading),
                  ],
                ),
                //width: calculateSize(732),
              ),
            ),
          ],
        ));
  }

  void dologin() {}
}
