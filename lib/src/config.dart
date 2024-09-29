import 'package:flutter/material.dart';

const brickColors = [
  // Color(0xffff0000),
  // Color(0xffff7f00),
  // Color(0xffffd700),
  // Color(0xff7fff00),
  // Color(0xff00ff00),
  // Color(0xff00ff7f),
  // Color(0xff00ffff),
  // Color(0xff007fff),
  // Color(0xff4b0082),
  // Color(0xff8a2be2),

  // Color(0xfff94144),
  // Color(0xfff3722c),
  // Color(0xfff8961e),
  // Color(0xfff9844a),
  // Color(0xfff9c74f),
  // Color(0xff90be6d),
  // Color(0xff43aa8b),
  // Color(0xff4d908e),
  // Color(0xff277da1),
  // Color(0xff577590),

//   Color(0xffb30000), // Dark Red
// Color(0xffcc6600), // Dark Orange
// Color(0xffbfa700), // Dark Golden Yellow
// Color(0xff4d6600), // Olive Green
// Color(0xff003d00), // Dark Green
// Color(0xff004d00), // Dark Spring Green
// Color(0xff004d4d), // Dark Cyan
// Color(0xff004080), // Dark Azure
// Color(0xff2a004d), // Dark Indigo
// Color(0xff5a2d91)  // Dark Violet

Color(0xffd44f4f), // Slightly Lighter Red
Color(0xffd89e3f), // Slightly Lighter Orange
Color(0xffd4b747), // Slightly Lighter Golden Yellow
Color(0xff6d7f2a), // Slightly Lighter Olive Green
Color(0xff4b6e00), // Slightly Lighter Green
Color(0xff006b3e), // Slightly Lighter Spring Green
Color(0xff007d7d), // Slightly Lighter Cyan
Color(0xff0066cc), // Slightly Lighter Azure
Color(0xff3d0099), // Slightly Lighter Indigo
Color(0xff6b3d91)  // Slightly Lighter Violet
];

const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;
const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.03;
double batSpeed = 1000;
double batAcceleration = 1.0;
