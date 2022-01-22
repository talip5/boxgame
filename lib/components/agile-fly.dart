import 'dart:ui';

import 'package:boxgame/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';

class AgileFly extends Fly {

  double get speed => game.tileSize * 5;

  AgileFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List();
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
  }
}