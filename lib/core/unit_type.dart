enum UnitType { 
  warrior(100, 30, 1, 2, '⚔️', 'Guerrier'), 
  archer(70, 25, 3, 2, '🏹', 'Archer'), 
  tank(150, 20, 1, 1, '🛡️', 'Tank');

  final int _maxHealth;
  final int _attack;
  final int _range;
  final int _movement;
  final String _icon;
  final String _name;

  const UnitType(this._maxHealth, this._attack, this._range, this._movement, this._icon, this._name);

  int get maxHealth => _maxHealth;
  int get attack => _attack;
  int get range => _range;
  int get movement => _movement;
  String get icon => _icon;
  String get name => _name;
}

