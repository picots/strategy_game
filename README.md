# Strategy Game

A turn-based tactical strategy game built with Flutter. Command units across a grid-based battlefield, manage their movement and attacks, and outmaneuver your opponent to achieve victory.

## Features

- **Turn-Based Combat**: Players take turns moving units and performing attacks
- **Grid-Based Gameplay**: Navigate a strategic battlefield with positional mechanics
- **Unit System**: Different unit types with unique stats (health, attack, range, movement)
- **Two-Player Mode**: Local multiplayer with Blue and Red players
- **Real-Time UI**: Interactive game board with visual feedback
- **State Management**: Comprehensive game state tracking for moves and attacks

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── core/                  # Game logic and models
│   ├── player.dart        # Player management
│   ├── unit.dart          # Unit class and mechanics
│   └── unit_type.dart     # Unit type definitions
└── ui/                    # User interface
    ├── game_screen.dart       # Main game screen widget
    └── game_screen_state.dart # Game screen state management
```

## Getting Started

### Prerequisites

- Flutter SDK 3.8.0 or higher
- Dart SDK (included with Flutter)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/picots/strategy_game
cd strategy_game
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

### Supported Platforms

- Android
- iOS
- Linux
- macOS
- Windows
- Web

## Gameplay

### Basic Rules

- **Players**: Two players control blue and red units
- **Turn Structure**: Each player alternates turns to move and attack
- **Unit Actions**: Each unit can move within its movement range and attack within its attack range
- **Victory**: Defeat all opponent units or last standing player wins

### Unit Types

Units have the following attributes:
- **Health**: Current and maximum health points
- **Attack**: Damage dealt to opponents
- **Range**: Distance from which attacks can be performed
- **Movement**: Distance the unit can move per turn

## Development

### Building for Production

```bash
flutter build apk      # Android
flutter build ios      # iOS
flutter build linux    # Linux
flutter build windows  # Windows
flutter build macos    # macOS
flutter build web      # Web
```

### Running Tests

```bash
flutter test
```

## Architecture

The game follows a clean architecture pattern:

- **Core**: Contains pure game logic and data models (units, players, game rules)
- **UI**: Flutter widgets and state management for rendering the game

## Contributing

Feel free to fork this project and submit pull requests for improvements.

## License

This project is open source and available under the MIT License.
