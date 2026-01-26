import 'package:flutter/material.dart';

class Player {
  final Color color;
  bool hasMoved, hasAttacked;

  Player(this.color, {this.hasMoved = false, this.hasAttacked = false});

  static Player one = Player(Colors.blue);
  static Player two = Player(Colors.red);
}