import 'package:flutter/material.dart';

import 'unit_type.dart';
import 'player.dart';

class Unit {
  final UnitType type;
  final Player owner;
  int health;
  int row;
  int col;
  bool hasMoved;
  bool hasAttacked;

  Unit({
    required this.type,
    required this.owner,
    required this.health,
    required this.row,
    required this.col,
    this.hasMoved = false,
    this.hasAttacked = false,
  });

  int get maxHealth {
    switch (type) {
      case UnitType.warrior:
        return 100;
      case UnitType.archer:
        return 70;
      case UnitType.tank:
        return 150;
    }
  }

  int get attack {
    switch (type) {
      case UnitType.warrior:
        return 30;
      case UnitType.archer:
        return 25;
      case UnitType.tank:
        return 20;
    }
  }

  int get range {
    switch (type) {
      case UnitType.warrior:
        return 1;
      case UnitType.archer:
        return 3;
      case UnitType.tank:
        return 1;
    }
  }

  int get movement {
    switch (type) {
      case UnitType.warrior:
        return 2;
      case UnitType.archer:
        return 2;
      case UnitType.tank:
        return 1;
    }
  }

  String get icon {
    switch (type) {
      case UnitType.warrior:
        return '⚔️';
      case UnitType.archer:
        return '🏹';
      case UnitType.tank:
        return '🛡️';
    }
  }

  Color get color => owner == Player.one ? Colors.blue : Colors.red;
}