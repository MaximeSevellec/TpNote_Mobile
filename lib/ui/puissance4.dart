import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:td2_flutter/ui/games.dart';

class Puissance4 extends StatelessWidget {
  const Puissance4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puissance 4'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Puissance4Board(),
    );
  }
}

class Puissance4Board extends StatefulWidget {
  const Puissance4Board({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Puissance4BoardState createState() => _Puissance4BoardState();
}

class MinimaxAI {
  int getBestMove(List<List<int>> grid, BuildContext context) {
    int bestMove = -1;
    int bestScore = -1000;
    for (int column = 0; column < grid[0].length; column++) {
      if (grid[0][column] == 0) {
        List<List<int>> gridCopy =
            List.generate(grid.length, (r) => List.from(grid[r]));
        for (int row = gridCopy.length - 1; row >= 0; row--) {
          if (gridCopy[row][column] == 0) {
            gridCopy[row][column] = 2;
            int score = minimax(gridCopy, 0, false, context);
            if (score > bestScore) {
              bestScore = score;
              bestMove = column;
            }
            break;
          }
        }
      }
    }
    return bestMove;
  }

  int minimax(List<List<int>> grid, int depth, bool isMaximizing,
      BuildContext context) {
    int result = checkWinner(grid);
    if (result != 0) {
      return result == 2 ? 1 : -1;
    }
    if (depth == context.read<SettingViewModel>().niveauJeuPuissance4) {
      return 0;
    }
    if (isMaximizing) {
      int bestScore = -1000;
      for (int column = 0; column < grid[0].length; column++) {
        if (grid[0][column] == 0) {
          List<List<int>> gridCopy =
              List.generate(grid.length, (r) => List.from(grid[r]));
          for (int row = gridCopy.length - 1; row >= 0; row--) {
            if (gridCopy[row][column] == 0) {
              gridCopy[row][column] = 2;
              int score = minimax(gridCopy, depth + 1, false, context);
              bestScore = bestScore > score ? bestScore : score;
              break;
            }
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int column = 0; column < grid[0].length; column++) {
        if (grid[0][column] == 0) {
          List<List<int>> gridCopy =
              List.generate(grid.length, (r) => List.from(grid[r]));
          for (int row = gridCopy.length - 1; row >= 0; row--) {
            if (gridCopy[row][column] == 0) {
              gridCopy[row][column] = 1;
              int score = minimax(gridCopy, depth + 1, true, context);
              bestScore = bestScore < score ? bestScore : score;
              break;
            }
          }
        }
      }
      return bestScore;
    }
  }

  int checkWinner(List<List<int>> grid) {
    for (int row = 0; row < grid.length; row++) {
      for (int column = 0; column < grid[0].length; column++) {
        if (grid[row][column] != 0) {
          if (column + 3 < grid[0].length &&
              grid[row][column] == grid[row][column + 1] &&
              grid[row][column] == grid[row][column + 2] &&
              grid[row][column] == grid[row][column + 3]) {
            return grid[row][column];
          }
          if (row + 3 < grid.length) {
            if (grid[row][column] == grid[row + 1][column] &&
                grid[row][column] == grid[row + 2][column] &&
                grid[row][column] == grid[row + 3][column]) {
              return grid[row][column];
            }
            if (column + 3 < grid[0].length &&
                grid[row][column] == grid[row + 1][column + 1] &&
                grid[row][column] == grid[row + 2][column + 2] &&
                grid[row][column] == grid[row + 3][column + 3]) {
              return grid[row][column];
            }
            if (column - 3 >= 0 &&
                grid[row][column] == grid[row + 1][column - 1] &&
                grid[row][column] == grid[row + 2][column - 2] &&
                grid[row][column] == grid[row + 3][column - 3]) {
              return grid[row][column];
            }
          }
        }
      }
    }
    return 0;
  }
}

class _Puissance4BoardState extends State<Puissance4Board> {
  final int rows = 6;
  final int columns = 7;
  late List<List<int>> grid;
  late int currentPlayer;
  late MinimaxAI ai;

  @override
  void initState() {
    super.initState();
    initializeGame();
    ai = MinimaxAI();
  }

  void initializeGame() {
    grid = List.generate(rows, (_) => List.generate(columns, (_) => 0));
    currentPlayer = 1;
    setState(() {});
  }

  void dropPiece(int column, BuildContext context) {
    String whoIsWinner = "";
    setState(() {
      for (int row = rows - 1; row >= 0; row--) {
        if (grid[row][column] == 0) {
          grid[row][column] = currentPlayer;
          if (checkWin(row, column)) {
            whoIsWinner = currentPlayer == 1 ? "Joueur 1" : "IA";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Joueur $currentPlayer a gagné !'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        initializeGame();
                      },
                      child: const Text('Rejouer'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Games()));
                        },
                        child: const Text('Retour')),
                  ],
                );
              },
            );
            break;
          }
          // if toutes les cases sont rempli
          bool isTie = true;
          for (int r = 0; r < rows; r++) {
            for (int c = 0; c < columns; c++) {
              if (grid[r][c] == 0) {
                isTie = false;
                break;
              }
            }
          }
          if (isTie) {
            whoIsWinner = "Personne";
            break;
          }
          currentPlayer = currentPlayer == 1 ? 2 : 1;
          break;
        }
      }
      // Si le joueur actuel est l'IA, elle joue
      if (currentPlayer == 2 && whoIsWinner == "") {
        int bestMove = ai.getBestMove(grid, context);
        dropPiece(bestMove, context);
      }
    });
    if (whoIsWinner == "Joueur 1") {
      context.read<SettingViewModel>().addScore(
          context.read<SettingViewModel>().pseudos,
          "Puissance 4 - Niveau ${context.read<SettingViewModel>().niveauJeuPuissance4}",
          "Gagné");
      if (context.read<SettingViewModel>().niveauJeuPuissance4 ==
              context.read<SettingViewModel>().niveauPuissance4 &&
          context.read<SettingViewModel>().niveauJeuPuissance4 < 6) {
        context.read<SettingViewModel>().niveauPuissance4 += 1;
        context.read<SettingViewModel>().niveauJeuPuissance4 += 1;
      }
    } else if (whoIsWinner == "IA") {
      context.read<SettingViewModel>().addScore(
          context.read<SettingViewModel>().pseudos,
          "Puissance 4 - Niveau ${context.read<SettingViewModel>().niveauJeuPuissance4}",
          "Perdu");
    } else if (whoIsWinner == "Personne") {
      context.read<SettingViewModel>().addScore(
          context.read<SettingViewModel>().pseudos,
          "Puissance 4 - Niveau ${context.read<SettingViewModel>().niveauJeuPuissance4}",
          "Egalité");
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Egalité'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    initializeGame();
                  },
                  child: const Text('Rejouer'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Games()));
                  },
                  child: const Text('Retour'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  bool checkWin(int row, int column) {
    // Vérifie les alignements verticaux
    for (int r = 0; r <= rows - 4; r++) {
      if (grid[r][column] == currentPlayer &&
          grid[r + 1][column] == currentPlayer &&
          grid[r + 2][column] == currentPlayer &&
          grid[r + 3][column] == currentPlayer) {
        return true;
      }
    }
    // Vérifie les alignements horizontaux
    for (int c = 0; c <= columns - 4; c++) {
      if (grid[row][c] == currentPlayer &&
          grid[row][c + 1] == currentPlayer &&
          grid[row][c + 2] == currentPlayer &&
          grid[row][c + 3] == currentPlayer) {
        return true;
      }
    }
    // Vérifie les alignements diagonaux (descendants)
    for (int r = 0; r <= rows - 4; r++) {
      for (int c = 0; c <= columns - 4; c++) {
        if (grid[r][c] == currentPlayer &&
            grid[r + 1][c + 1] == currentPlayer &&
            grid[r + 2][c + 2] == currentPlayer &&
            grid[r + 3][c + 3] == currentPlayer) {
          return true;
        }
      }
    }
    // Vérifie les alignements diagonaux (ascendants)
    for (int r = 3; r < rows; r++) {
      for (int c = 0; c <= columns - 4; c++) {
        if (grid[r][c] == currentPlayer &&
            grid[r - 1][c + 1] == currentPlayer &&
            grid[r - 2][c + 2] == currentPlayer &&
            grid[r - 3][c + 3] == currentPlayer) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: 1,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
            ),
            itemCount: rows * columns,
            itemBuilder: (context, index) {
              int row = index ~/ columns;
              int column = index % columns;
              return GestureDetector(
                onTap: () {
                  dropPiece(column, context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: grid[row][column] == 0
                        ? Colors.blue
                        : grid[row][column] == 1
                            ? Colors.red
                            : Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(4.0),
                ),
              );
            },
          ),
        ),
        Text('Joueur actuel: ${currentPlayer == 1 ? "Joueur 1" : "IA"}'),
      ],
    );
  }
}
