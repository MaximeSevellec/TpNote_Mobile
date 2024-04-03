import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'accueil.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JouerEnCours',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: const Accueil(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EcranSettings()));
            },
            child: const Icon(Icons.settings),
          ),
          FloatingActionButton(
            onPressed: () {
              // demande de confirmation
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmation'),
                    content: const Text(
                        'Voulez-vous vraiment effacer toutes les données ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Non'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<SettingViewModel>().clearSettings();
                        },
                        child: const Text('Oui'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
