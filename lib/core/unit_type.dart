enum UnitType { 
  warrior(100, 30, 1, 2, '⚔️'), 
  archer(70, 25, 3, 2, '🏹'), 
  tank(150, 20, 1, 1, '🛡️');

  final int _maxHealth;
  final int _attack;
  final int _range;
  final int _movement;
  final String _icon;

  const UnitType(this._maxHealth, this._attack, this._range, this._movement, this._icon);

  int get maxHealth => _maxHealth;
  int get attack => _attack;
  int get range => _range;
  int get movement => _movement;
  String get icon => _icon;
}

