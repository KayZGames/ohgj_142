import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_142/src/shared/components.dart';

class BackgroundRenderingSystem extends VoidEntitySystem {
  CameraManager cm;
  CanvasRenderingContext2D ctx;
  BackgroundRenderingSystem(this.ctx);

  @override
  void initialize() {
    cm = world.getManager(CameraManager);
  }

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
  void initialize() {
    cm = world.getManager(CameraManager);
  }

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    ctx
      ..fillStyle = 'darkbrown'
      ..fillRect(
          p.x * cm.width, p.y * cm.height, cm.width * 0.05, cm.height * 0.03);
  }
}
