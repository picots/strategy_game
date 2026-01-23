import 'package:flutter_test/flutter_test.dart';
import 'package:strategy_game/core/unit.dart';
import 'package:strategy_game/core/player.dart';
import 'package:strategy_game/core/unit_type.dart';

void main() {
  group('Tests', () {
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
      
      expect(target.health, 40); // 70 - 30 = 40
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
    late List<Unit> units;
    
    setUp(() {
      units = [
        Unit(type: UnitType.warrior, owner: Player.one, health: 100, row: 0, col: 0),
        Unit(type: UnitType.archer, owner: Player.two, health: 70, row: 5, col: 5),
      ];
    });
    
    test('Nombre d\'unités initial', () {
      expect(units.length, 2);
    });
    
    test('Éliminer une unité', () {
      units.removeAt(0);
      expect(units.length, 1);
    });
  });
}