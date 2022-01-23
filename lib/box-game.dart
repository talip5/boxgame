import 'dart:ui';
import 'package:boxgame/components/backyard.dart';
import 'package:boxgame/components/fly-delete.dart';
import 'package:boxgame/components/fly-render.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/components/fly1.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:boxgame/components/house-fly.dart';
import 'package:boxgame/components/agile-fly.dart';
import 'package:boxgame/components/drooler-fly.dart';
import 'package:boxgame/components/hungry-fly.dart';
import 'package:boxgame/components/macho-fly.dart';
import 'package:boxgame/view.dart';
import 'package:boxgame/views/home-view.dart';
import 'package:boxgame/components/start-button.dart';
import 'package:boxgame/views/lost-view.dart';
import 'package:boxgame/controllers/spawner.dart';
import 'package:boxgame/components/credits-button.dart';
import 'package:boxgame/components/help-button.dart';
import 'package:boxgame/views/help-view.dart';
import 'package:boxgame/views/credits-view.dart';
import 'package:boxgame/components/score-display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boxgame/components/highscore-display.dart';

class BoxGame extends Game with TapDetector{

  Size screenSize;
  double tileSize;
  Rect bgRect;
  List<Fly> flies;
  Backyard _backyard;
  Random rnd=Random();
  View activeView = View.home;
  HomeView homeView;
  StartButton startButton;
  LostView lostView;
  FlySpawner spawner;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;
  int score;
  ScoreDisplay scoreDisplay;
  final SharedPreferences storage;
  HighscoreDisplay highscoreDisplay;

  BoxGame(this.storage){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    resize(await Flame.util.initialDimensions());
    _backyard=Backyard(this);
    homeView = HomeView(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    spawner = FlySpawner(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    scoreDisplay = ScoreDisplay(this);
    score = 0;
    highscoreDisplay = HighscoreDisplay(this);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2.025));
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {
    _backyard.render(canvas);
    highscoreDisplay.render(canvas);
    if (activeView == View.playing) scoreDisplay.render(canvas);
    flies.forEach((Fly fly) => fly.render(canvas));
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }
    if (activeView == View.lost) lostView.render(canvas);
    helpButton.render(canvas);
    creditsButton.render(canvas);
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  void update(double t) {
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(t);
    if (activeView == View.playing) scoreDisplay.update(t);
      }

@override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
    super.resize(size);
  }

  @override
  void onTapDown(TapDownDetails details) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

// help button
    if (!isHandled && helpButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

// credits button
    if (!isHandled && creditsButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled && startButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }
    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(details.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });
      if (activeView == View.playing && !didHitAFly) {
        activeView = View.lost;
      }
    }
       super.onTapDown(details);
  }
}