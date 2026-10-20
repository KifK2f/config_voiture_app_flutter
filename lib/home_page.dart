import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<StatefulWidget> createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  bool isOn = true;
  double min = 0;
  double max = 100;
  double current = 0;

  late TextEditingController _controller;

  void unfocusMethod(){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  //Initialisation de _controller
  @override
  void initState(){
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose(){
    _controller.dispose(); //On le mets avant le dispose
    super.dispose();
  }

  final Map<String, bool> _options = {
    "GPS": false,
    "Caméra de recul": false,
    "Clim par zone": false,
    "Régulateur de vitesse": false,
    "Toit ouvrant": false,
    "Siège chauffant": false,
    "Roue de secours": false,
    "Jantes alu": false
  };

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white
            ),
        ),
        actions: [
          ElevatedButton(
              onPressed: ((){
                setState(() {
                  unfocusMethod();
                });
              }),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                  "Je valide",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 11,
                  fontWeight: FontWeight.bold
                ),
              ))
        ],

        //Couleur de l'appBar
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Texte de bienvenue
              Text(
                  "Bienvenue : ${_controller.text}",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18
                  ),
              ),

              //Card qui affiche les images
              Card(
                color: Colors.blueGrey,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                  // height: 150,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "Voici la voiture faite pour vous",
                          style: TextStyle(fontSize: 15),
                      ),
                      Image.asset(
                        "assets/images/MG.jpg",
                        // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                      ),
                      Text(
                        "MG cyberster",
                        style: TextStyle(fontSize: 15),
                      ),                    ],
                  ),
                ),
              ),


              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Entrer votre nom"
                ),
              ),

              //Le Slider
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Nombre de kilomètres annuel : ${current.toInt()}",
                    style: TextStyle(fontSize: 15),
                ),
              ), //toInt() pour avoir des nombres entier
              Row(
                children: [
                  // Text(min.toString()),
                  Expanded(
                      child: Slider(
                        min: min,
                        max: max,
                        value: current,
                        onChanged: (newValue){
                          setState(() {
                            current = newValue;
                          });
                        }
                      )
                  ),
                  // Text(max.toString()),
                ],
              ),
              Divider(),

              //Un Switch pour le type de moteur
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Moteur ${isOn ? 'électrique' : 'thermique'}"
                  ),
                  Switch(
                      value: isOn,
                      onChanged: (newBool){
                        setState(() {
                          isOn = newBool;
                        });
                      })
                ],
              ),

              Divider(),

              // Un Radio pour le nombre de places
              Row(
                children: [
                  Text("Nombre de place "),
                ],
              ),

              Divider(),
              // Un Checkbox pour les options
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Option du véhivule"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _options.keys.map((key){
                  return CheckboxListTile(
                    title: Text(key),
                    value: _options[key],
                    onChanged: (b){
                      setState(() {
                        _options[key] = b ?? false;
                      });
                    },
                  );
                }).toList(),
              )


            ],
          ),
        ),
      ),
    );
  }
}