import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final _questionController = TextEditingController();
  final _nameController = TextEditingController();
  String _selectedCategory = 'Chiens'; // Valeur par défaut correspondant à une catégorie animale
  List<Map<String, String>> _questions = [];

  final List<String> _animalCategories = [
    'Chiens',
    'Chats',
    'Rongeurs',
    'Oiseaux',
    'Reptiles',
    'Poissons',
    'Autres animaux',
  ];

  @override
  void dispose() {
    _questionController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitQuestion() {
    final String question = _questionController.text;
    final String name = _nameController.text;

    // Ajouter la question à la liste
    setState(() {
      _questions.add({
        'category': _selectedCategory,
        'name': name,
        'question': question,
      });
    });

    // Réinitialiser les champs de texte après la soumission de la question.
    _questionController.clear();
    _nameController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Question soumise'),
          content: Text('Merci, $name, votre question a été soumise : "$question"'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Catégorie',
              ),
              items: _animalCategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Votre question',
              ),
              maxLines: 3, // Permet plusieurs lignes pour la question
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Votre nom',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: const Text('Poser une question'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Questions posées :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length, // Nombre d'éléments dans la liste des questions
                itemBuilder: (BuildContext context, int index) {
                  final question = _questions[index]; // Récupérer la question à l'index actuel
                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catégorie : ${question['category']}', // Afficher la catégorie de la question
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Utilisateur : ${question['name']}', // Afficher le nom de l'utilisateur
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question['question']!, // Afficher le texte de la question
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
