import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carnet de santé',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Carnet de santé'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? _selectedAnimal;
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  String? _vetName;
  DateTime? _lastVisitDate;
  DateTime? _selectedLastVisitDate;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                DropdownButton<String>(
                  value: _selectedAnimal,
                  hint: const Text('Sélectionnez un animal'),
                  items: <String>['Chien', 'Chat', 'Rongeur', 'Oiseau'].map((
                      String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedAnimal = newValue;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nom de l\'animal',
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedGender,
                  hint: const Text('Sélectionnez le sexe'),
                  items: <String>['Femelle', 'Mâle'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedBirthDate = picked;
                      });
                    }
                  },
                  child: const Text('Sélectionnez la date de naissance'),
                ),
                Text(
                  _selectedBirthDate != null
                      ? 'Date de naissance : ${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
                      : 'Date de naissance non sélectionnée',
                ),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nom du vétérinaire',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _lastVisitDate = picked;
                      });
                    }
                  },
                  child: const Text(
                      'Sélectionnez la date de la dernière visite chez le vétérinaire'),
                ),
                Text(
                  _selectedLastVisitDate != null
                      ? 'Dernière visite chez le vétérinaire : ${_selectedLastVisitDate!.day}/${_selectedLastVisitDate!.month}/${_selectedLastVisitDate!.year}'
                      : 'Date de dernière visite non sélectionnée',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}