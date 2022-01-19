import 'package:boxgame/box-game.dart';
import 'dart:ui';

class Fly{

  Rect flyRect;
  Paint flyPaint;

  BoxGame game;

  Fly(this.game, double x, double y) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint = Paint();
    flyPaint.color = Color(0xff6ab04c);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(flyRect, flyPaint);
  }

  @override
  void update(double t) {
    // TODO: implement update

  }
}