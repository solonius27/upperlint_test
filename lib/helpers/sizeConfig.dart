import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double? _blockWidth = 0;
  static double? _blockHeight = 0;

  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    // if (orientation == Orientation.portrait) {
    //   _screenWidth = constraints.maxWidth;
    //   _screenHeight = constraints.maxHeight;
    //   isPortrait = true;
    //   if (_screenWidth < 450) {
    //     isMobilePortrait = true;
    //   }
    // }

    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _blockWidth = _screenWidth! / 100;
    _blockHeight = _screenHeight! / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    // print(_blockWidth);
    // print(_blockHeight);
    // print(_screenWidth);
  }
}
