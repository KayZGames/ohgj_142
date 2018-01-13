import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_142/src/shared/components.dart';

class AccelerationSystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;
  Mapper<Velocity> vm;
  CameraManager cm;

  AccelerationSystem() : super(new Aspect.forAllOf([Acceleration, Velocity]));

  @override
  void initialize() {
    cm = world.getManager(CameraManager);
  }

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    final v = vm[entity];
    v.x += a.x * world.delta;
    v.y += a.y * world.delta;
  }
}

class MovementSystem extends EntityProcessingSystem {
  Mapper<Velocity> vm;
  Mapper<Position> pm;
  CameraManager cm;

  MovementSystem() : super(new Aspect.forAllOf([Velocity, Position]));

  @override
  void initialize() {
    cm = world.getManager(CameraManager);
  }

  @override
  void processEntity(Entity entity) {
    final v = vm[entity];
    final p = pm[entity];
    p.x += v.x * world.delta;
    p.y += v.y * world.delta;
  }
}

class GravitySystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;
  Mapper<Velocity> vm;
  Mapper<Position> pm;

  GravitySystem()
      : super(new Aspect.forAllOf([Acceleration, Position, Velocity]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    final a = am[entity];
    final v = vm[entity];
    print(a.y);
    if (p.y < 0.1) {
      a.y += 10.0 * world.delta;
      p.y = 0.1;
    } else if (p.y < 0.9) {
//      a.y *= (0.9 - p.y) * world.delta;
    } else if (p.y > 0.9 && v.y > 0.0) {
      a.y = 0.0;
      v.y = 0.0;
      p.y = 0.9;
    }
    print(a.y);
  }
}

class WaterDragSystem extends EntityProcessingSystem {
  Mapper<Velocity> vm;
  Mapper<Position> pm;
  Mapper<Acceleration> am;

  WaterDragSystem()
      : super(new Aspect.forAllOf([Velocity, Position, Acceleration]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    final v = vm[entity];
    final a = am[entity];

    if (p.y >= 0.1 && p.y <= 0.9) {
      v.x *= 0.9;
      v.y *= 0.9;
    }

    if (p.x < 0.0 && v.x < 0.0) {
      p.x = 0.0;
      v.x = 0.0;
      a.x = 0.0;
    } else if (p.x > 0.975 && v.x > 0.0) {
      p.x = 0.975;
      v.x = 0.0;
      a.x = 0.0;
    }
  }
}

class TreasureCollectionSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  Mapper<Treasure> treasureMapper;
  TagManager tm;

  TreasureCollectionSystem()
      : super(new Aspect.forAllOf([Treasure, Position])..exclude([Controller]));

  @override
  void processEntity(Entity entity) {
    final playerEntity = tm.getEntity(playerTag);
    final pp = pm[playerEntity];
    final tp = pm[entity];
    if (pp.y >= 0.88 &&
        (pp.x - tp.x).abs() < 0.01 &&
        !treasureMapper.has(playerEntity)) {
      playerEntity
        ..addComponent(new Treasure())
        ..changedInWorld();
      entity.deleteFromWorld();
    }
  }
}

class TreasureDeliveringSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  Mapper<Treasure> treasureMapper;
  TagManager tm;

  TreasureDeliveringSystem() : super(new Aspect.forAllOf([Boat, Position]));

  @override
  void processEntity(Entity entity) {
    final playerEntity = tm.getEntity(playerTag);
    final pp = pm[playerEntity];
    final tp = pm[entity];
    if (pp.y <= 0.12 &&
        (pp.x - tp.x).abs() < 0.01 &&
        treasureMapper.has(playerEntity)) {
      playerEntity
        ..removeComponent(Treasure)
        ..changedInWorld();
      world.createAndAddEntity(
          [new Treasure(), new Position(random.nextDouble(), 0.9)]);
    }
  }
}
