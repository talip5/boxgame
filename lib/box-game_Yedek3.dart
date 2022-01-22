import 'dart:ui';
import 'package:boxgame/components/fly-delete.dart';
import 'package:boxgame/components/fly-render.dart';
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
  FlyRender _flyRender=FlyRender();
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
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    _fly1.update(t);
    //_flyRender.update(t);
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  @override
  void onTapDown(TapDownDetails details) {
    flies.forEach((Fly fly) {
      if (fly.flyRect.contains(details.globalPosition)) {
        fly.onTapDown();
      }
    });
    if (_fly1.flyRect1.contains(details.globalPosition)) {
      _fly1.onTapDown();
    }
    super.onTapDown(details);
  }
}