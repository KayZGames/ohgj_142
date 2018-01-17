import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_142/src/shared/components.dart';

class BackgroundRenderingSystem extends VoidEntitySystem {
  CameraManager cm;
  CanvasRenderingContext2D ctx;
  BackgroundRenderingSystem(this.ctx);

  @override
  void processSystem() {
    ctx
      ..fillStyle = 'cyan'
      ..fillRect(0, 0, cm.width, cm.height * 0.1)
      ..fillStyle = 'blue'
      ..fillRect(0, cm.height * 0.1, cm.width, cm.height * 0.8)
      ..fillStyle = 'brown'
      ..fillRect(0, cm.height * 0.9, cm.width, cm.height * 0.1);
  }
}

class BoatRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  CameraManager cm;
  CanvasRenderingContext2D ctx;

  BoatRenderingSystem(this.ctx) : super(new Aspect.forAllOf([Position, Boat]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    ctx
      ..fillStyle = 'darkbrown'
      ..fillRect(
          p.x * cm.width, p.y * cm.height, cm.width * 0.05, cm.height * 0.03);
  }
}

class DiverRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  CameraManager cm;
  CanvasRenderingContext2D ctx;
  DiverRenderingSystem(this.ctx)
      : super(new Aspect.forAllOf([Position, Diver]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    ctx
      ..fillStyle = 'black'
      ..fillRect(
          p.x * cm.width, p.y * cm.height, cm.width * 0.025, cm.height * 0.015)
      ..fillStyle = 'yellow'
      ..fillRect(
          p.x * cm.width + 0.015 * cm.width,
          p.y * cm.height - 0.004 * cm.height,
          cm.width * 0.0075,
          cm.height * 0.005);
  }
}

class TreasureRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  CameraManager cm;
  CanvasRenderingContext2D ctx;

  TreasureRenderingSystem(this.ctx)
      : super(new Aspect.forAllOf([Position, Treasure]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    ctx
      ..fillStyle = 'yellow'
      ..fillRect(
          p.x * cm.width, p.y * cm.height, cm.width * 0.01, cm.height * 0.01);
  }
}

class ScoreRenderingSystem extends EntityProcessingSystem {
  Mapper<Boat> bm;
  CanvasRenderingContext2D ctx;
  ScoreRenderingSystem(this.ctx) : super(new Aspect.forAllOf([Boat]));

  @override
  void processEntity(Entity entity) {
    final score = bm[entity].score;
    ctx
      ..fillStyle = 'black'
      ..font = '20px Verdana'
      ..fillText('$score treasures secured', 10, 10);
  }
}
