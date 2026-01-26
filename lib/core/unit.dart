import 'package:flutter/material.dart';

import 'unit_type.dart';
import 'player.dart';

class Unit {
  final UnitType type;
  final Player owner;
  int health;
  int row;
  int col;

  Unit({
    required this.type,
    required this.owner,
    required this.health,
    required this.row,
    required this.col,
  });

  int get maxHealth => type.maxHealth;

  int get attack => type.attack;

  int get range => type.range;

  int get movement => type.movement;
  
  String get icon => type.icon;

  Color get color => owner.color;

  String get name => type.name;
}