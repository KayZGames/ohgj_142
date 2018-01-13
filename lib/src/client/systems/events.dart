import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:templatetest/src/shared/components.dart';

class ControllerSystem extends GenericInputHandlingSystem {
  Mapper<Controller> cm;

  ControllerSystem() : super(new Aspect.forAllOf([Controller]));

  @override
  void processEntity(Entity entity) {
    final c = cm[entity];
    if (up) {
      c.up = true;
    } else if (down) {
      c.down = true;
    }

    if (left) {
      c.left = true;
    } else if (right) {
      c.right = true;
    }
  }
}
