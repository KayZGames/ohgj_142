import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ohgj_142/src/shared/components.dart';

class ControllerSystem extends GenericInputHandlingSystem {
  Mapper<Acceleration> am;

  ControllerSystem() : super(new Aspect.forAllOf([Controller, Acceleration]));

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    if (up) {
      a.y = -1.0;
    } else if (down) {
      a.y = 1.0;
    }

    if (left) {
      a.x = -1.0;
    } else if (right) {
      a.x = 1.0;
    }
  }
}
