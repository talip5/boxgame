import 'package:boxgame/box-game.dart';
import 'dart:ui';

class Fly1{

  Rect flyRect1;
  Paint flyPaint1;

  BoxGame game;

  Fly1(this.game, double x, double y) {
    flyRect1 = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint1 = Paint();
    flyPaint1.color = Color(0xffffffff);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(flyRect1, flyPaint1);
  }

  @override
  void update(double t) {
    // TODO: implement update

  }
}