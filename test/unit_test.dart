import 'package:flutter_test/flutter_test.dart';
import 'package:strategy_game/core/unit.dart';
import 'package:strategy_game/core/player.dart';
import 'package:strategy_game/core/unit_type.dart';
import 'package:strategy_game/ui/game_screen_state.dart';

void main() {
  group('Unités', () {
    test('Guerrier a les bonnes statistiques', () {
      final warrior = Unit(
        type: UnitType.warrior,
        owner: Player.one,
        health: 100,
        row: 0,
        col: 0,
      );
      
      expect(warrior.maxHealth, 100);
      expect(warrior.attack, 30);
      expect(warrior.movement, 2);
      expect(warrior.range, 1);
    });
    
    test('Attaque réduit les PV', () {
      final attacker = Unit(
        type: UnitType.warrior,
        owner: Player.one,
        health: 100,
        row: 0,
        col: 0,
      );
      
      final target = Unit(
        type: UnitType.archer,
        owner: Player.two,
        health: 70,
        row: 1,
        col: 0,
      );
      
      target.health -= attacker.attack;
      
      expect(target.health, 40);
    });
    
    test('Distance de mouvement correcte', () {
      final unit = Unit(
        type: UnitType.tank,
        owner: Player.one,
        health: 150,
        row: 0,
        col: 0,
      );
      
      expect(unit.movement, 1);
    });
  });
  
  group('Game State', () {
    late GameScreenState gameState;
    
    setUp(() {
      gameState = GameScreenState();
      gameState.initState();
    });
    
    test('Nombre d\'unités initial', () {
      expect(gameState.units.length, 12);
    });
    
    test('Éliminer une unité', () {
      gameState.units.removeAt(0);
      expect(gameState.units.length, 11);
    });

    test('Récupérer une unité par position', () {
      final unit1 = gameState.getUnitAt(0, 0);
      final unit2 = gameState.getUnitAt(0, 1);
      expect(unit1, null);
      expect(unit2?.type, UnitType.archer);
    });

    test('Mouvement légal', () {
      final unit1 = gameState.getUnitAt(0, 1)!;
      final unit2 = gameState.getUnitAt(0, 2)!;
      final unit3 = gameState.getUnitAt(0, 3)!;
      expect(gameState.canMove(unit1, 1, 1), true);
      expect(gameState.canMove(unit1, 3, 1), false);
      expect(gameState.canMove(unit2, 2, 2), true);
      expect(gameState.canMove(unit2, 1, 0), false);
      expect(gameState.canMove(unit3, 1, 3), true);
      expect(gameState.canMove(unit3, 2, 1), false);
    });

    test('Attaque légale', () {
      final attacker = Unit(owner: Player.one, type: UnitType.archer, health: 70, row: 2, col: 1);
      final targetInRange = Unit(owner: Player.two, type: UnitType.warrior, health: 100, row: 5, col: 1);
      final targetSameOwner = Unit(owner: Player.one, type: UnitType.warrior, health: 100, row: 0, col: 2);
      final targetOutOfRange = Unit(owner: Player.two, type: UnitType.warrior, health: 100, row: 7, col: 2);

      expect(gameState.canAttack(attacker, targetInRange), true);
      expect(gameState.canAttack(attacker, targetSameOwner), false);
      expect(gameState.canAttack(attacker, targetOutOfRange), false);
    });

    
  });
}