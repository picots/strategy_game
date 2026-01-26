import 'package:flutter/material.dart';

import '../core/player.dart';
import '../core/unit.dart';
import '../core/unit_type.dart';
import 'game_screen.dart';

class GameScreenState extends State<GameScreen> {
  static const int gridSize = 8;
  List<Unit> units = [];
  Unit? selectedUnit;
  Player currentPlayer = Player.one;
  String message = "Tour du Joueur 1 - Sélectionnez une unité";

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    units = [
      Unit(type: UnitType.archer, owner: Player.one, health: 70, row: 7, col: 1),
      Unit(type: UnitType.warrior, owner: Player.one, health: 100, row: 7, col: 2),
      Unit(type: UnitType.tank, owner: Player.one, health: 150, row: 7, col: 3),
      Unit(type: UnitType.tank, owner: Player.one, health: 150, row: 7, col: 4),
      Unit(type: UnitType.warrior, owner: Player.one, health: 100, row: 7, col: 5),
      Unit(type: UnitType.archer, owner: Player.one, health: 70, row: 7, col: 6),
      
      Unit(type: UnitType.archer, owner: Player.two, health: 70, row: 0, col: 1),
      Unit(type: UnitType.warrior, owner: Player.two, health: 100, row: 0, col: 2),
      Unit(type: UnitType.tank, owner: Player.two, health: 150, row: 0, col: 3),
      Unit(type: UnitType.tank, owner: Player.two, health: 150, row: 0, col: 4),
      Unit(type: UnitType.warrior, owner: Player.two, health: 100, row: 0, col: 5),
      Unit(type: UnitType.archer, owner: Player.two, health: 70, row: 0, col: 6),
    ];
  }

  Unit? getUnitAt(int row, int col) {
    try {
      return units.firstWhere((u) => u.row == row && u.col == col);
    } catch (e) {
      return null;
    }
  }

  bool canMove(Unit unit, int toRow, int toCol) {
    if (unit.hasMoved) return false;
    if (getUnitAt(toRow, toCol) != null) return false;
    
    int distance = (unit.row - toRow).abs() + (unit.col - toCol).abs();
    return distance <= unit.movement;
  }

  bool canAttack(Unit attacker, Unit target) {
    if (attacker.hasAttacked) return false;
    if (attacker.owner == target.owner) return false;
    
    int distance = (attacker.row - target.row).abs() + (attacker.col - target.col).abs();
    return distance <= attacker.range;
  }

  void _moveUnit(Unit unit, int toRow, int toCol) {
    setState(() {
      unit.row = toRow;
      unit.col = toCol;
      unit.hasMoved = true;
      selectedUnit = null;
      message = "${currentPlayer == Player.one ? 'Joueur 1' : 'Joueur 2'} - Unité déplacée";
    });
  }

  void _attack(Unit attacker, Unit target) {
    setState(() {
      target.health -= attacker.attack;
      attacker.hasAttacked = true;
      
      if (target.health <= 0) {
        units.remove(target);
        message = "${attacker.name} de ${attacker.owner == Player.one ? 'Joueur 1' : 'Joueur 2'} a éliminé ${target.name} de ${target.owner == Player.one ? 'Joueur 1' : 'Joueur 2'} !";
        _checkWinCondition();
      } else {
        message = "${attacker.name} de ${attacker.owner == Player.one ? 'Joueur 1' : 'Joueur 2'} attaque ${target.name} de ${target.owner == Player.one ? 'Joueur 1' : 'Joueur 2'} pour ${attacker.attack} dégâts !";
      }
      
      selectedUnit = null;
    });
  }

  void _checkWinCondition() {
    bool player1HasUnits = units.any((u) => u.owner == Player.one);
    bool player2HasUnits = units.any((u) => u.owner == Player.two);
    
    if (!player1HasUnits) {
      _showWinDialog(Player.two);
    } else if (!player2HasUnits) {
      _showWinDialog(Player.one);
    }
  }

  void _showWinDialog(Player winner) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Victoire !'),
        content: Text('${winner == Player.one ? 'Joueur 1' : 'Joueur 2'} a gagné !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _initializeGame();
                selectedUnit = null;
                currentPlayer = Player.one;
                message = "Tour du Joueur 1 - Sélectionnez une unité";
              });
            },
            child: const Text('Rejouer'),
          ),
        ],
      ),
    );
  }

  void _endTurn() {
    setState(() {
      for (var unit in units) {
        if (unit.owner == currentPlayer) {
          unit.hasMoved = false;
          unit.hasAttacked = false;
        }
      }
      
      currentPlayer = currentPlayer == Player.one ? Player.two : Player.one;
      selectedUnit = null;
      message = "Tour du ${currentPlayer == Player.one ? 'Joueur 1' : 'Joueur 2'} - Sélectionnez une unité";
    });
  }

  void _onCellTap(int row, int col) {
    Unit? unitAtCell = getUnitAt(row, col);
    
    if (selectedUnit == null) {
      if (unitAtCell != null && unitAtCell.owner == currentPlayer) {
        setState(() {
          selectedUnit = unitAtCell;
          message = "${unitAtCell.name} sélectionné - Déplacez ou attaquez";
        });
      }
    } else {
      if (unitAtCell == null) {
        if (canMove(selectedUnit!, row, col)) {
          _moveUnit(selectedUnit!, row, col);
        }
      } else if (unitAtCell.owner != currentPlayer) {
        if (canAttack(selectedUnit!, unitAtCell)) {
          _attack(selectedUnit!, unitAtCell);
        }
      } else if (unitAtCell == selectedUnit) {
        setState(() {
          selectedUnit = null;
          message = "Unité désélectionnée";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu de Stratégie Tour par Tour'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: currentPlayer == Player.one ? Colors.blue[100] : Colors.red[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: _endTurn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentPlayer == Player.one ? Colors.blue : Colors.red,
                  ),
                  child: const Text('Fin du Tour'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                    ),
                    itemCount: gridSize * gridSize,
                    itemBuilder: (context, index) {
                      int row = index ~/ gridSize;
                      int col = index % gridSize;
                      Unit? unit = getUnitAt(row, col);
                      bool isSelected = selectedUnit != null && 
                                       selectedUnit!.row == row && 
                                       selectedUnit!.col == col;
                      bool canMoveHere = selectedUnit != null && 
                                        unit == null && 
                                        canMove(selectedUnit!, row, col);
                      bool canAttackHere = selectedUnit != null && 
                                          unit != null && 
                                          canAttack(selectedUnit!, unit);

                      return GestureDetector(
                        onTap: () => _onCellTap(row, col),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.yellow[300]
                                : canMoveHere
                                    ? Colors.green[200]
                                    : canAttackHere
                                        ? Colors.red[200]
                                        : (row + col) % 2 == 0
                                            ? Colors.grey[300]
                                            : Colors.grey[100],
                            border: Border.all(color: Colors.black45, width: 0.5),
                          ),
                          child: unit != null
                              ? LayoutBuilder(
                                  builder: (context, constraints) {
                                    double cellSize = constraints.maxWidth;
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          unit.icon,
                                          style: TextStyle(fontSize: cellSize * 0.4),
                                        ),
                                        SizedBox(height: cellSize * 0.05),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: cellSize * 0.1),
                                          height: cellSize * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: unit.health / unit.maxHealth,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: unit.health > unit.maxHealth * 0.5
                                                    ? Colors.green
                                                    : unit.health > unit.maxHealth * 0.25
                                                        ? Colors.orange
                                                        : Colors.red,
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Text(
                  'Légende:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegendItem('⚔️', 'Guerrier', 'ATK: 30, HP: 100, MOV: 2'),
                    _buildLegendItem('🏹', 'Archer', 'ATK: 25, HP: 70, RNG: 3'),
                    _buildLegendItem('🛡️', 'Tank', 'ATK: 20, HP: 150, MOV: 1'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String icon, String name, String stats) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        Text(stats, style: const TextStyle(fontSize: 8), textAlign: TextAlign.center),
      ],
    );
  }
}