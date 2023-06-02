import 'package:flutter/material.dart';

//import 'FindVet.dart';

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
    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FindVet()),
    );*/
  }


  void navigateToDestinationPage(BuildContext context) {
  }

  void navigateToFoodRecommendations() {
    // recommandat-ions de nourriture
  }

  void navigateToAnimalLocation() {
    // localisation de l'animal
  }

  void navigateToBlog() {
    // page du blog
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
      body: SingleChildScrollView(
        child : Center(
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
                ElevatedButton(
                  onPressed: navigateToHealthBook,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '../assets/images/carneSante.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Carnet de santé',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: navigateToFindVet,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '../assets/images/veterinaire.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Trouver un vétérinaire',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: navigateToFoodRecommendations,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '../assets/images/croquettes.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Recommandations nourriture',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: navigateToAnimalLocation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '../assets/images/endroit.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Localisation de mon animal',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: navigateToBlog,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        '../assets/images/blog.png',
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Blog',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
