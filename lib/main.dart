import 'package:flutter/material.dart';
// Importer les plugins firebase_core et cloud_firestore
import 'package:firebase_core/firebase_core.dart';
import 'package:petcare/screens/carnet_de_sante.dart';
import 'firebase_options.dart';
import 'package:petcare/screens/FindVet.dart';
import 'package:petcare/screens/LocalisationAnimal.dart';
import 'package:petcare/screens/Blog.dart';
import 'widgets/custom_elevatedbutton.dart';

// TODO 1 : fix the Bottom Overflowed" error in the homePage (the content within a widget exceeds the available space)
//TODO 2 :creating reusable widgets "ElevatedButton"
// TODO  3 : rename the homePage class in this file

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => carnetSante()),
    );
  }

  void navigateToFindVet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FindVet()),

    );
  }



  void navigateToDestinationPage(BuildContext context) {}

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
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'PetCare',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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