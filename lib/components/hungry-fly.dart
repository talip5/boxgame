import 'dart:ui';

import 'package:boxgame/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';

class HungryFly extends Fly {
  HungryFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List();
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.65, game.tileSize * 1.65);
  }
}