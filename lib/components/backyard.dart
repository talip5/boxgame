import 'dart:ui';
import 'package:boxgame/box-game.dart';
import 'package:flame/sprite.dart';

class Backyard {
  final BoxGame game;
  Sprite bgSprite;
  Rect bgRect;
  double difference=0;

  Backyard(this.game) {
    difference=game.screenSize.height-(game.tileSize*23);
    bgSprite = Sprite('bg/backyard.png');
    bgRect = Rect.fromLTWH(0,
      //game.screenSize.height - (game.tileSize * 23),
      difference,
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
    //bgSprite.render(c);
  }

  void update(double t) {}
}
