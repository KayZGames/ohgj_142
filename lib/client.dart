library client;

import 'package:ohgj_142/shared.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ohgj_142/src/shared/components.dart';
import 'package:ohgj_142/src/shared/systems/logic.dart';

import 'src/client/systems/events.dart';
import 'src/client/systems/rendering.dart';

class Game extends GameBase {
  Game() : super.noAssets('ohgj_142', '#game') {
    handleResize(canvas.clientWidth, canvas.clientHeight);
  }

  @override
  void createEntities() {
    addEntity([
      new Controller(),
      new Position(0.52, 0.1),
      new Diver(),
      new Acceleration(0.0, 0.0),
      new Velocity(0.0, 0.0)
    ]);
    addEntity([new Boat(), new Position(0.5, 0.08)]);
  }

  @override
  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new ControllerSystem(),
        new GravitySystem(),
        new AccelerationSystem(),
        new WaterDragSystem(),
        new MovementSystem(),
        new CanvasCleaningSystem(canvas),
        new BackgroundRenderingSystem(ctx),
        new BoatRenderingSystem(ctx),
        new DiverRenderingSystem(ctx),
        new FpsRenderingSystem(ctx, fillStyle: 'black'),
      ],
      GameBase.physics: [
        // add at least one
      ]
    };
  }

  @override
  void handleResize(int width, int height) {
    width = max(800, width);
    height = max(600, height);
    super.handleResize(width, height);
  }
}
