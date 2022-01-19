import 'dart:ui';
import 'package:boxgame/components/fly-delete.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/components/fly1.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'dart:math';

class BoxGame extends Game with TapDetector{

  Size screenSize;
  double tileSize;
  Rect bgRect;
  Paint bgPaint;
  List<Fly> flies;
  Fly1 _fly1;
  FlyDelete _flyDelete;
  double xWhite=150;
  Random rnd=Random();

  BoxGame(){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    resize(await Flame.util.initialDimensions());
    spawnFly();
    _fly1=Fly1(this, xWhite, 150);
    _flyDelete=FlyDelete(this, 250, 250);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    flies.forEach((Fly fly) => fly.render(canvas));
    _fly1.render(canvas);
    _flyDelete.render(canvas);
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    //xWhite=xWhite+ 20 * t;
    //_fly1=Fly1(this, xWhite, 150);
    //_fly1.update(t);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }
  @override
  void onTapDown(TapDownDetails details) {
    if(_fly1.flyRect1.contains(details.globalPosition)) {
      spawnFly();
    }

    if(_flyDelete.flyRect1.contains(details.globalPosition)){
      if(flies.isNotEmpty) {
        flies.removeLast();
      }else{
        print('no record!');
        _fly1=Fly1(this, 0, 0);
      }
    }
    if(_fly1.flyRect1.contains(details.globalPosition) ||
        _flyDelete.flyRect1.contains(details.globalPosition))
    {
      print('fly and fly-delete inside');
    }else{
      print('fly and fly-delete outside');
    }

    super.onTapDown(details);
  }
}