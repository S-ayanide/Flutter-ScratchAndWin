import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: import images
  AssetImage blank = AssetImage("images/blank.png");
  AssetImage lucky = AssetImage("images/money.png");
  AssetImage unlucky = AssetImage("images/sad.png");

  //TODO: get an array
  List<String> itemArray;
  int luckyNumber;
  String message = "";
  int counter = 0;

  //TODO: init array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //Delay Method
  Delay(){
    Future.delayed(const Duration(milliseconds: 1600),(){
      setState(() {
        this.resetGame();
        counter = 0;
      });
    });
  }

  //TODO: define a getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return blank;
  }

  //Display Message
  DisplayMessage(){
    setState(() {
      message = "You have reached maximum tries";  
      Delay();
    });
  }

  //TODO: play game method
  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
        this.message = "Yay ! You got it";
        Delay();
      });
    } else if(luckyNumber != index && counter <= 5){
      setState(() {
        itemArray[index] = "unlucky";
        counter++;
      });
      if(counter == 5){
        DisplayMessage();
      }
    }
  }

  //TODO: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //TODO: Reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      this.message = "";
      this.counter = 0;
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99AAAB),
      appBar: AppBar(
        title: Text('Scratch and win', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF2C3335),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(1.0),
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    width: 40.0,
                    height: 40.0,
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(100.0, 12.0, 100.0, 12.0),
                  color: Color(0xFF2F363F),
                  child: Text(this.message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                    color: Colors.black,
                    child: Text("Reset All", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    onPressed: (){
                      this.resetGame();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                    color: Colors.black,
                    child: Text("Show All", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    onPressed: (){
                      this.showAll();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
            padding: EdgeInsets.fromLTRB(140.0, 10.0, 100.0, 10.0),
            color: Color(0xFF2C3335),
            child: Text("LearnCodeOnline.in", style: TextStyle(color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0.0, 0, 0),
            padding: EdgeInsets.fromLTRB(120.0, 10.0, 100.0, 10.0),
            color: Color(0xFF47535E),
            child: Text("Developed by Sayan Mondal", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
