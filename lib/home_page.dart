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

  void unfocusMethod(){
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
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
                  color: Colors.blueGrey
                ),
              ))
        ],

        //Couleur de l'appBar
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          ],
        ),
      ),
    );
  }
}