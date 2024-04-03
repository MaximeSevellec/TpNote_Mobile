import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:td2_flutter/ui/games.dart';
import 'dart:math';

class Morpion extends StatefulWidget {
  const Morpion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  EcranBoard createState() => EcranBoard();
}

class Move {
  final int row;
  final int col;

  Move(this.row, this.col);
}

class EcranBoard extends State<Morpion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: const Center(
        child: Board(),
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<String>> grid = [];
  String currentPlayer = '';

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    setState(() {
      grid = List.generate(3, (_) => List.filled(3, ''));
      currentPlayer = 'X';
    });
  }

  void tapped(int row, int col) {
    if (grid[row][col] == '' && !checkWinner()) {
      setState(() {
        grid[row][col] = currentPlayer;
        if (checkWinner()) {
          int nbCoupsJoueForX = 0;
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              if (grid[i][j] == 'X') {
                nbCoupsJoueForX++;
              }
            }
          }
          context.read<SettingViewModel>().addScore(
              context.read<SettingViewModel>().pseudos,
              "Morpion - Niveau ${context.read<SettingViewModel>().niveauJeuMorpion}",
              currentPlayer == 'X'
                  ? "Gagné (en $nbCoupsJoueForX coup(s))"
                  : "Perdu (en $nbCoupsJoueForX coup(s))");
          if (currentPlayer == 'X') {
            if (context.read<SettingViewModel>().niveauJeuMorpion ==
                    context.read<SettingViewModel>().niveauMorpion &&
                context.read<SettingViewModel>().niveauMorpion < 6) {
              context.read<SettingViewModel>().niveauMorpion =
                  context.read<SettingViewModel>().niveauMorpion + 1;
              context.read<SettingViewModel>().niveauJeuMorpion =
                  context.read<SettingViewModel>().niveauMorpion;
            }
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Gagnant'),
              content: Text('Gagnant: $currentPlayer !'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeGame();
                  },
                  child: const Text('Jouer encore'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Games()));
                  },
                  child: const Text('Retour'),
                )
              ],
            ),
          );
        } else if (!grid.any((row) => row.contains(''))) {
          context.read<SettingViewModel>().addScore(
              context.read<SettingViewModel>().pseudos,
              "Morpion - Niveau ${context.read<SettingViewModel>().niveauJeuMorpion}",
              "Egalité");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Egalité'),
              content: const Text("Match nul !"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeGame();
                  },
                  child: const Text('Jouer encore'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Games()));
                  },
                  child: const Text('Retour'),
                )
              ],
            ),
          );
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
          if (currentPlayer == 'O') {
            playAI(context.read<SettingViewModel>().niveauJeuMorpion);
          }
        }
      });
    }
  }

  // ignore: constant_identifier_names
  static const int INFINITY = 1000;

  void playAI(int depth) {
    List<Move> availableMoves = [];

    // Trouver toutes les cases vides
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] == '') {
          availableMoves.add(Move(i, j));
        }
      }
    }

    // Utiliser Minimax pour choisir le meilleur coup parmi les cases vides disponibles
    if (availableMoves.isNotEmpty) {
      int bestScore = -INFINITY;
      Move bestMove = availableMoves[0];
      for (Move move in availableMoves) {
        grid[move.row][move.col] = 'O'; // Simulation du coup de l'IA
        int score = minimax(grid, depth, false);
        grid[move.row][move.col] = ''; // Annuler le coup

        if (score > bestScore) {
          bestScore = score;
          bestMove = move;
        }
      }

      tapped(bestMove.row, bestMove.col); // Jouer le meilleur coup
    }
  }

  int minimax(List<List<String>> grid, int depth, bool isMaximizing) {
    // Vérifier si le jeu est terminé ou s'il y a match nul
    int score = evaluate(grid);
    if (score == 10) {
      return score;
    }
    if (score == -10) {
      return score;
    }
    if (!isMovesLeft(grid) || depth == 0) {
      // Vérifier la profondeur maximale
      return 0;
    }

    // Maximiser le score pour l'IA
    if (isMaximizing) {
      int bestScore = -INFINITY;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (grid[i][j] == '') {
            grid[i][j] = 'O';
            bestScore = max(
                bestScore,
                minimax(
                    grid, depth - 1, !isMaximizing)); // Réduire la profondeur
            grid[i][j] = '';
          }
        }
      }
      return bestScore;
    }
    // Minimiser le score pour le joueur
    else {
      int bestScore = INFINITY;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (grid[i][j] == '') {
            grid[i][j] = 'X';
            bestScore = min(
                bestScore,
                minimax(
                    grid, depth - 1, !isMaximizing)); // Réduire la profondeur
            grid[i][j] = '';
          }
        }
      }
      return bestScore;
    }
  }

  bool isMovesLeft(List<List<String>> grid) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] == '') {
          return true;
        }
      }
    }
    return false;
  }

  int evaluate(grid) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == 'O' && grid[i][1] == 'O' && grid[i][2] == 'O') {
        return 10;
      }
      if (grid[i][0] == 'X' && grid[i][1] == 'X' && grid[i][2] == 'X') {
        return -10;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == 'O' && grid[1][i] == 'O' && grid[2][i] == 'O') {
        return 10;
      }
      if (grid[0][i] == 'X' && grid[1][i] == 'X' && grid[2][i] == 'X') {
        return -10;
      }
    }
    // Check diagonals
    if (grid[0][0] == 'O' && grid[1][1] == 'O' && grid[2][2] == 'O') {
      return 10;
    }
    if (grid[0][0] == 'X' && grid[1][1] == 'X' && grid[2][2] == 'X') {
      return -10;
    }
    if (grid[0][2] == 'O' && grid[1][1] == 'O' && grid[2][0] == 'O') {
      return 10;
    }
    if (grid[0][2] == 'X' && grid[1][1] == 'X' && grid[2][0] == 'X') {
      return -10;
    }
    return 0;
  }

  bool checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == currentPlayer &&
          grid[i][1] == currentPlayer &&
          grid[i][2] == currentPlayer) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == currentPlayer &&
          grid[1][i] == currentPlayer &&
          grid[2][i] == currentPlayer) {
        return true;
      }
    }
    // Check diagonals
    if (grid[0][0] == currentPlayer &&
        grid[1][1] == currentPlayer &&
        grid[2][2] == currentPlayer) {
      return true;
    }
    if (grid[0][2] == currentPlayer &&
        grid[1][1] == currentPlayer &&
        grid[2][0] == currentPlayer) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (row) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (col) => GestureDetector(
              onTap: () => tapped(row, col),
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Center(
                  child: Text(
                    grid[row][col],
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
