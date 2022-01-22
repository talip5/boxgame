import 'package:boxgame/box-game.dart';
import 'dart:ui';

class Fly {

  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

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
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
  }

  void onTapDown() {
    isDead = true;
    flyPaint.color = Color(0xffff4757);
    game.spawnFly();
  }
}