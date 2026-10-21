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

  late bool _electric = true;

  double min = 0;
  double max = 25000;
  double _current = 0;

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

  //Bouton Radio
  List<int> placeList = [2, 4, 5, 7];
  late int? _placesSelected = 2;


  //Pour le checkBOX
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

  //La liste de voitures
  final List<Car> _cars = [
    Car(name: "MG cyberster", url: "MG", places: 2, isElectric: true),
    Car(name: "R5 électrique", url: "R5", places: 4, isElectric: true),
    Car(name: "Tesla", url: "tesla", places: 5, isElectric: true),
    Car(name: "Van VW", url: "Van", places: 7, isElectric: true),
    Car(name: "Alpine", url: "Alpine", places: 2, isElectric: false),
    Car(name: "Fiat 500", url: "Fiat 500", places: 4, isElectric: false),
    Car(name: "Peugeot 3008", url: "P3008", places: 5, isElectric: false),
    Car(name: "Dacia Jogger", url: "Jogger", places: 7, isElectric: false),
  ];

  //La logique de choix de voiture
  // late final _carSelected = _cars.firstWhere((car) => car.isElectric == _electric && car.places == _placesSelected);
  String get _message {
    // Selon le moteur et le nombre de kilomètres
    //Si l'utilisateur fait plus de 15 000kms et veut un modèle électrique
    if(_current>= 15000 && _electric){
      return "Vous devriez penser à un moteur thermique compte tenu du nombre de kilomètres";
    } else if(_current<= 5000 && !_electric){
      return "Vous faites peu de kilomètres, pensez à regarder les voiture électriques";
    } else {
      return "Voici la voiture faite pour vous";
    }
  }

  Car get _carSelected {
   return _cars.firstWhere(
           (car) => car.isElectric == _electric && car.places == _placesSelected
   );
  }


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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: const Size(90, 40), // Largeur : 90, hauteur : 40
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                  "Je valide",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 13,
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
                          // "Voici la voiture faite pour vous",
                        _message,
                        style: TextStyle(fontSize: 15),
                      ),
                      Image.asset(
                        // "assets/images/${_carSelected.urlString}.jpg",
                        _carSelected.urlString
                        // width: MediaQuery.of(context).size.width, //Pour prendre la largerur selon l'écran du smartphone
                      ),
                      Text(
                        // "${_carSelected.name}",
                        _carSelected.name,
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
                    "Nombre de kilomètres annuel : ${_current.toInt()}",
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
                        value: _current,
                        onChanged: (newValue){
                          setState(() {
                            _current = newValue;
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
                    "Moteur ${_electric ? 'électrique' : 'thermique'}"
                  ),
                  Switch(
                      value: _electric,
                      onChanged: (newBool){
                        setState(() {
                            _electric = newBool;
                        });
                      })
                ],
              ),

              Divider(),

              // Un Radio pour le nombre de places
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nombre de places : ${_placesSelected ?? ''}"),
                  RadioGroup<int>(
                    groupValue: _placesSelected,
                    onChanged: (value){
                      setState(() {
                        _placesSelected = value;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: placeList.map((place){
                        return Column(
                          children: [
                            Radio<int>(value: place),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                ]
              ),



              Divider(),
              // Un Checkbox pour les options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Option du véhivule"),
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
                  ),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}

class Car{
  String name;
  String url;
  int places;
  bool isElectric;

  Car({required this.name, required this.url, required this.places, required this.isElectric});

  String get urlString => "assets/images/$url.jpg";
}