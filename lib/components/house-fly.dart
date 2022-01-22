import 'dart:ui';

import 'package:boxgame/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';

class HouseFly extends Fly {
  //HouseFly(BoxGame game, double x, double y) : super(game, x, y) {
    HouseFly(BoxGame game,double x,double y):super(game) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }
}