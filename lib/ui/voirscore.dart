import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';

class DisplayScore extends StatelessWidget {
  const DisplayScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildScoreList(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreList(BuildContext context) {
    final settingsModel = context.watch<SettingViewModel>();
    final scores = settingsModel.score;

    if (scores == [] || scores.isEmpty) {
      return const Center(
        child: Text(
          'Aucun score enregistré',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: scores.length,
      itemBuilder: (context, index) {
        final score = scores[scores.length - 1 - index];
        final scoreInfo = score.split(':');
        final pseudo = scoreInfo[0];
        final niveau = scoreInfo[1];
        final scoreValue = scoreInfo[2];

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              '$pseudo - Jeu: $niveau',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Score: $scoreValue',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
