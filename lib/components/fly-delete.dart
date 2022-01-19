import 'package:boxgame/box-game.dart';
import 'dart:ui';

class FlyDelete{

  Rect flyRect1;
  Paint flyPaint1;

  BoxGame game;

  FlyDelete(this.game, double x, double y) {
    flyRect1 = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    flyPaint1 = Paint();
    flyPaint1.color = Color(0xffffff00);
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