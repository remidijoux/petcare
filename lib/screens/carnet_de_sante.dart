  import 'package:flutter/material.dart';
  import 'package:petcare/main.dart';
  import 'package:petcare/widgets/details.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:intl/intl.dart';
  import 'package:petcare/widgets/submit_btn.dart';
  import 'package:petcare/models/pet_user_model.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_core/firebase_core.dart';


  class carnetSante extends StatefulWidget {
    const carnetSante({Key? key}) : super(key: key);

    @override
    State<carnetSante> createState() => _carnetSanteState();
  }

  class _carnetSanteState extends State<carnetSante> {

    final Map<String, IconData> _typeIconMap = {
      'chien': FontAwesomeIcons.dog,
      'chat': FontAwesomeIcons.cat,
      'oiseau': FontAwesomeIcons.dove,
      'cheval': FontAwesomeIcons.horse,
      "poisson": FontAwesomeIcons.fish,
    };

    //constructor
    _carnetSanteState() {
      _selectedVal = _petTypeList[0];
    }

    @override
    void dispose() {
      _petnamecontroller.dispose();
      super.dispose();

      _petvetcontroller.dispose();
      super.dispose();
    }

    // Variables
    final _petnamecontroller = TextEditingController();
    final _petvetcontroller = TextEditingController();
    bool? _listTileCheckBox = false;
    final _petTypeList = ["chien", "chat", "oiseau", "cheval", "poisson"];
    String? _selectedVal = "";
    DateTime? _lastVisitDate;

    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Form"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                //Todo: add Image
                const Text(
                    "Veuillez remplir le formulaire ci-dessous pour ajouter les informations relatives à votre animal de compagnie"),
                const SizedBox(height: 30.0),

                // form

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Dropdownbutton
                        DropdownButtonFormField(
                          value: _selectedVal,
                          items: _petTypeList
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedVal = val as String;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.blueAccent,
                          ),
                          decoration: InputDecoration(
                            labelText: "Type de l'animal",
                            border: OutlineInputBorder(),
                            prefixIcon: _selectedVal != null
                                ? Icon(
                                    _typeIconMap[_selectedVal],
                                    color: Colors.blueAccent,
                                  )
                                : null,
                          ),
                        ),

                        const SizedBox(height: 20.0),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else
                              null;
                          },
                          controller: _petnamecontroller,
                          decoration: InputDecoration(
                              labelText: 'Nom de l\'animal',
                              prefixIcon: Icon(Icons.pets),
                              prefixIconColor: Colors.blueAccent,
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10.0),
                        //Use to add space  between Text fields
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else
                              null;
                          },
                          controller: _petvetcontroller,
                          decoration: InputDecoration(
                              labelText: 'Nom du vétérinaire',
                              prefixIcon: Icon(FontAwesomeIcons.userNurse),
                              prefixIconColor: Colors.blueAccent,
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 10.0),
                        //checkbox
                        CheckboxListTile(
                          value: _listTileCheckBox,
                          title: Text('Votre animal est-il vacciné ? '),

                          onChanged: (val) {
                            setState(() {
                              _listTileCheckBox = val;
                            });
                          },
                          // The controlAffinity property in the CheckboxListTile widget is used to determine the
                          // placement of the checkbox widget relative to the label. By setting it to ListTileControlAffinity.trailing,
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        // DatePicker
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
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _lastVisitDate != null
                                  ? 'Date de dernière visite : ${DateFormat('dd/MM/yyyy').format(_lastVisitDate!)}'
                                  : 'Date de dernière visite non sélectionnée',
                            ),
                          ),
                        ),

                        //button submit
                        const SizedBox(height: 20.0),
                        submitBtn(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              PetUser petUser = PetUser();

                              petUser.petName = _petnamecontroller.text;
                              petUser.vetName = _petvetcontroller.text;
                              petUser.isVaccinated = _listTileCheckBox!;
                              petUser.petType = _selectedVal!;
                              petUser.lastVisitDate = _lastVisitDate!;

                              final petCollection = FirebaseFirestore.instance.collection('pets');
                              await petCollection.add({
                                'petName': petUser.petName,
                                'vetName': petUser.vetName,
                                'isVaccinated': petUser.isVaccinated,
                                'petType': petUser.petType,
                                'lastVisitDate': petUser.lastVisitDate,
                              });

                             // success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('les informations sont bien enregistrées '),
                                    backgroundColor: Colors.green
                                ),
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Details(petUser: petUser, typeIconMap: _typeIconMap);
                              }));
                            }
                          },
                        )
                      ],
                    )),
              ],
            ),
          ));
    }


  }
