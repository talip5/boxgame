import 'package:boxgame/box-game.dart';
import 'dart:ui';
import 'package:flame/sprite.dart';

class Fly {

  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  BoxGame game;
  Offset targetLocation;

  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
     }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  @override
  void render(Canvas canvas) {
      if (isDead) {
        deadSprite.renderRect(canvas, flyRect.inflate(2));
      } else {
        flyingSprite[flyingSpriteIndex.toInt()].renderRect(canvas, flyRect.inflate(2));
      }
    }

  @override
  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
    else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
    }
  }

  void onTapDown() {
    isDead = true;
  }
}