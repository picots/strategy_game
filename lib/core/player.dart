import 'package:flutter/material.dart';

enum Player { 
  one(Colors.blue), 
  two(Colors.red);

  final Color _color;

  const Player(this._color);

  Color get color => _color;
}