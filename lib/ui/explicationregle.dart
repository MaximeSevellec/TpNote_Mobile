import 'package:flutter/material.dart';

class ExplicationRegle extends StatelessWidget {
  const ExplicationRegle({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explication des règles'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Dans cette application, vous avez la possibilité de vous inscrire avec un pseudo et de jouer à deux jeux classiques : le morpion et le Puissance 4. Chacun de ces jeux propose six niveaux de difficulté. L'objectif est de progresser à travers tous les niveaux de chaque jeu.",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              "Pour le morpion, vous devez placer vos marques de manière stratégique sur un tableau à neuf cases. Vous devez essayer de former une ligne horizontale, verticale ou diagonale de trois de vos marques tout en bloquant les tentatives de votre adversaire de former une telle ligne.",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "Quant au Puissance 4, le but est de placer vos jetons de manière à aligner quatre d'entre eux horizontalement, verticalement ou en diagonale sur un plateau de six colonnes et sept lignes. Comme pour le morpion, vous devez également bloquer les tentatives de votre adversaire de réaliser cet objectif.",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 10.0),
            Text(
              "Chaque niveau de difficulté propose des adversaires virtuels de plus en plus compétents, nécessitant une réflexion stratégique plus approfondie et une anticipation des mouvements de l'adversaire. En progressant à travers les niveaux, vous améliorez vos compétences dans ces jeux classiques et relevez de nouveaux défis excitants à chaque étape.",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "En résumé, l'application vous offre une expérience ludique où vous pouvez affiner vos compétences en jouant au morpion et au Puissance 4 à différents niveaux de difficulté, avec pour objectif ultime de maîtriser tous les niveaux des deux jeux.",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
