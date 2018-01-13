library client;

import 'package:ohgj_142/shared.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:templatetest/src/shared/components.dart';

import 'src/client/systems/events.dart';
import 'src/client/systems/rendering.dart';

class Game extends GameBase {

  Game() : super.noAssets('ohgj_142', '#game');

  @override
  void createEntities() {
    addEntity([new Controller()]);
  }

  @override
  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new ControllerSystem(),
        new CanvasCleaningSystem(canvas),
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
