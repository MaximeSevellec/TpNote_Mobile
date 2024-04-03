import 'package:flutter/material.dart';
import 'package:td2_flutter/ui/explicationregle.dart';
import 'package:td2_flutter/ui/games.dart';
import 'package:td2_flutter/ui/voirscore.dart';

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/mydata/puissance4.png',
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/mydata/icone.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Games()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Démarrer une partie',
                  style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DisplayScore()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child:
                  const Text('Voir mes scores', style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExplicationRegle()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Explication des règles',
                  style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
