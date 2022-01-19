import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:boxgame/box-game.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  //await Flame.util.setLandscape();

  BoxGame game = BoxGame();
   runApp(game.widget);
 }