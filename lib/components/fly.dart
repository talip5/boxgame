import 'package:boxgame/box-game.dart';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:boxgame/view.dart';
import 'package:boxgame/components/callout.dart';

class Fly {

  Rect flyRect;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  BoxGame game;
  Offset targetLocation;
  Callout callout;

  double get speed => game.tileSize * 3;

  Fly(this.game) {
    setTargetLocation();
    callout = Callout(this);
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
        if (game.activeView == View.playing) {
          callout.render(canvas);
        }
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
      callout.update(t);
    }
  }

  void onTapDown() {
    if (!isDead) {
      isDead = true;

      if (game.activeView == View.playing) {
        game.score += 1;
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }
      }
    }
  }
}