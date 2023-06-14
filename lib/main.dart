import 'package:flutter/material.dart';

import 'FindVet.dart';
import 'Blog.dart';
import 'LocalisationAnimal.dart';
import 'widgets/custom_elevatedbutton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PETCARE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PETCARE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigateToHealthBook() {
    //carnet de santé
  }

  void navigateToFindVet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FindVet()),
    );
  }


  void navigateToDestinationPage(BuildContext context) {
  }

  void navigateToFoodRecommendations() {
    // recommandat-ions de nourriture
  }

  void navigateToAnimalLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocalisationAnimal()),
    );
  }

  void navigateToBlog() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlogPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              child: Image.asset('../assets/images/Animaux.png'),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: [
                CustomElevatedButton(
                  onPressed: navigateToHealthBook,
                  buttonText: 'Carnet de santé',
                  imagePath: '../assets/images/carneSante.png',
                ),
                CustomElevatedButton(
                  onPressed: navigateToFindVet,
                  buttonText: 'Trouver un vétérinaire',
                  imagePath: '../assets/images/veterinaire.png',
                ),
                CustomElevatedButton(
                  onPressed: navigateToFoodRecommendations,
                  buttonText: 'Recommandations nourriture',
                  imagePath: '../assets/images/croquettes.png',
                ),
                CustomElevatedButton(
                  onPressed: navigateToAnimalLocation,
                  buttonText: 'Localisation de mon animal',
                  imagePath: '../assets/images/endroit.png',
                ),
                CustomElevatedButton(
                  onPressed: navigateToBlog,
                  buttonText: 'Blog',
                  imagePath: '../assets/images/blog.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}