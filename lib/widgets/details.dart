import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/models/pet_user_model.dart';

class Details extends StatelessWidget {
  Details({
    Key? key,
    required this.petUser, required this.typeIconMap
  }) : super(key: key);
  PetUser petUser;
  final Map<String, IconData> typeIconMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de votre animal de compagnie'),
        //back button
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.grey.shade300)),
                // TODO: Pick select icon in the form
                leading: IconButton(
                  icon: Icon(
                    typeIconMap[petUser.petType],
                    color: Colors.blueAccent,
                  ),

                  onPressed: () {},
                ),
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Chip(
                          label: Text("informations de votre animal de compagnie"),
                          // background color
                          labelStyle: TextStyle(color: Colors.white)),
                      Text(petUser.petName as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("Nom veterinaire : ${petUser.vetName as String}"),
                      Row(
                        children: [
                          const SizedBox(height: 20.0),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blueAccent,
                            ),
                            child: Text(petUser.petType as String,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0)),
                          )
                        ],
                      )
                    ]),
              )
            ],
          )),
    );
  }
}
