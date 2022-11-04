import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:upperlint_test/helpers/sizeConfig.dart';

//const
const primarycolor = Color(0xff171B70);
const textcolor1 = Color(0xff3F3D56);

double calculateSize(double size) {
  var val = size / 8.53;
  return val * SizeConfig.heightMultiplier!;
}

final pageMargin = EdgeInsets.only(
  left: calculateSize(28),
  right: calculateSize(28),
  top: calculateSize(20),
);

Widget verticalSpace(val) {
  return SizedBox(
    height: calculateSize(val),
  );
}

Widget horizontalSpace(val) {
  return SizedBox(
    width: calculateSize(val),
  );
}

BorderRadius circularRadius(val) {
  return BorderRadius.circular(calculateSize(val));
}

void navigate(BuildContext context, routeName,
    {replace = false, replaceall = false, dynamic args, delayed = false}) {
  if (replaceall) {
    if (delayed) {
      Future.delayed(const Duration(seconds: 2)).then((_) =>
          Navigator.of(context).pushNamedAndRemoveUntil(
              routeName, (route) => false,
              arguments: args));
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false,
          arguments: args);
    }
  } else if (replace) {
    if (delayed) {
      Future.delayed(const Duration(seconds: 2)).then((_) =>
          Navigator.of(context)
              .pushReplacementNamed(routeName, arguments: args));
    } else {
      Navigator.of(context).pushReplacementNamed(routeName, arguments: args);
    }
  } else {
    if (delayed) {
      Future.delayed(const Duration(seconds: 2)).then((value) =>
          Navigator.of(context).pushNamed(routeName, arguments: args));
    } else {
      Navigator.of(context).pushNamed(routeName, arguments: args);
    }
  }
}

Widget showmessage(context, message, {iserror = true, duration = 2}) {
  return Flushbar(
    title: iserror ? "ERROR" : "SUCCESS",
    message: message,
    titleColor: const Color(0xff2D2B2E),
    titleSize: calculateSize(14),
    messageSize: calculateSize(18),
    maxWidth: calculateSize(500),
    boxShadows: const [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 5,
        blurRadius: 5,
      ),
    ],
    messageColor: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: calculateSize(24)),
    borderRadius: BorderRadius.circular(calculateSize(16)),
    //borderColor: primarycolor,
    backgroundColor:
        iserror ? Colors.redAccent : Colors.greenAccent, //Color(0xffF0F8FF),
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: duration),
  )..show(context);
}

Widget appText(String tx, double size,
    {FontWeight weight = FontWeight.w400,
    topmargin = 0.0,
    bottommargin = 0.0,
    leftmargin = 0.0,
    rightmargin = 0.0,
    TextAlign align = TextAlign.center,
    Color color = Colors.black,
    double? space,
    FontStyle fontStyle = FontStyle.normal}) {
  return Container(
    margin: EdgeInsets.only(
        top: calculateSize(topmargin),
        bottom: calculateSize(bottommargin),
        left: calculateSize(leftmargin),
        right: calculateSize(rightmargin)),
    child: Text(
      tx,
      softWrap: true,
      //overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: TextStyle(
        fontSize: calculateSize(size),
        fontWeight: weight,
        fontStyle: fontStyle,
        color: color,
        letterSpacing: space,
      ),
    ),
  );
}

class AppTextFieldWidget extends StatelessWidget {
  final bool obscureText;
  final obscureTextcharacter;
  final textInputType;
  final labelText;
  final Function(String?)? fxsavedValue;
  final String? Function(String?)? fx;
  final String? initval;
  final enabled;
  final trailingButton;
  final prefixText;
  final controller;
  final focusNode;
  final maxLines;
  final innerlabeltext;
  final preIcons;
  final fontSize;
  final borderSideColor;
  final suffixtext;

  AppTextFieldWidget(
      {this.labelText,
      this.enabled = true,
      this.obscureText = false,
      this.initval,
      this.textInputType = TextInputType.text,
      this.fxsavedValue,
      this.fx,
      this.maxLines = 1,
      this.obscureTextcharacter = "*",
      this.trailingButton,
      this.prefixText,
      this.controller,
      this.focusNode,
      this.innerlabeltext,
      this.preIcons,
      this.borderSideColor = Colors.transparent,
      this.fontSize = 14.0,
      this.suffixtext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(labelText, 14,
            weight: FontWeight.w400, color: textcolor1, bottommargin: 2.0),
        TextFormField(
          enabled: enabled,
          initialValue: initval,
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          obscuringCharacter: "*",
          maxLines: maxLines,
          keyboardType: textInputType,
          textInputAction: TextInputAction.next,
          cursorColor: primarycolor,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: calculateSize(15),
            color: const Color(0xff2D2D2D),
          ),
          decoration: InputDecoration(
            fillColor: Color(0xffF6F6FF),
            filled: true,
            suffixIcon: trailingButton,
            suffixText: suffixtext,
            prefixIcon: preIcons,
            prefixText: prefixText,
            errorMaxLines: 3,
            contentPadding: EdgeInsets.symmetric(
                horizontal: calculateSize(16), vertical: calculateSize(24)),
            isDense: true,
            hintText: innerlabeltext,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: calculateSize(15),
              color: const Color(0xff2D2D2D),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffC4C4C4)),
                borderRadius: BorderRadius.circular(calculateSize(10))),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffC4C4C4)),
                borderRadius: BorderRadius.circular(calculateSize(10))),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffC4C4C4)),
                borderRadius: BorderRadius.circular(calculateSize(10))),
          ),
          onSaved: fxsavedValue,
          validator: fx,
        ),
        SizedBox(
          height: calculateSize(20),
        ),
      ],
    );
  }
}

Widget appButton(fx, tx,
    {color = primarycolor, textcolor = Colors.white, isloading = false}) {
  return GestureDetector(
    onTap: fx,
    child: Container(
      alignment: Alignment.center,
      //margin: EdgeInsets.symmetric(horizontal: calculateSize(20)),
      width: double.infinity,
      height: calculateSize(60),
      decoration: BoxDecoration(
        color: color,
        //border: Border.all(color: buttoncolor),
        borderRadius: BorderRadius.circular(
          calculateSize(10),
        ),
      ),
      child: isloading
          ? Container(
              height: calculateSize(20),
              width: calculateSize(20),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : appText(
              tx,
              20,
              weight: FontWeight.w600,
              color: Colors.white,
            ),
    ),
  );
}
