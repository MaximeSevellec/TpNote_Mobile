import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:td2_flutter/ui/morpion.dart';
import 'package:td2_flutter/ui/niveaux.dart';
import 'package:td2_flutter/ui/puissance4.dart';
import 'package:td2_flutter/ui/home.dart';

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démarrer une partie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: FormWidget(),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  String _pseudo = '';

  @override
  Widget build(BuildContext context) {
    final niveauJeuMorpion = context.read<SettingViewModel>().niveauJeuMorpion;
    final niveauJeuPuissance4 =
        context.read<SettingViewModel>().niveauJeuPuissance4;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Pseudo",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez insérer votre pseudo';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _pseudo = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Niveaux()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Center(
                      child: Text('Niveaux', style: TextStyle(fontSize: 30))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submit();
                    }
                  },
                  child: Center(
                    child: Text(
                      "Morpion \n Niveau: $niveauJeuMorpion",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submit2();
                    }
                  },
                  child: Center(
                    child: Text(
                      "Puissance 4 \n Niveau: $niveauJeuPuissance4",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<SettingViewModel>().pseudo = _pseudo;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Morpion()),
      );
    }
  }

  void _submit2() {
    if (_formKey.currentState!.validate()) {
      context.read<SettingViewModel>().pseudo = _pseudo;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Puissance4()),
      );
    }
  }
}
