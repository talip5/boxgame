import 'package:boxgame/box-game.dart';
import 'dart:ui';

class Fly{

  Rect flyRect;
  Paint flyPaint;
  int touchCount=0;

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

  void onTapDown() {
    if(touchCount<3) {
      switch(touchCount){
        case 0: {
          flyPaint.color = Color(0xffff4757);
        }
        break;
        case 1: {
          flyPaint.color = Color(0xffff00ff);
        }
        break;
        case 2: {
          flyPaint.color = Color(0xff00ffff);
        }
        break;
      }
      touchCount++;
    }
    print('fly onTap $touchCount');
  }
}