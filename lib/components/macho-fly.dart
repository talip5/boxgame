import 'dart:ui';

import 'package:boxgame/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';

class MachoFly extends Fly {

  double get speed => game.tileSize * 2.5;

  MachoFly(BoxGame game, double x, double y) : super(game) {
    flyingSprite = List();
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
  }
}