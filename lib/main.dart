import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solid Software Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Solid Software Flutter Test'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color;
  ColorGenerator colorGenerator;

  _MyHomePageState(){
    color = Colors.white;
    colorGenerator = ColorGenerator();

    double limit_of_operation = 10;
    double acceleration_x_before = 0;
    //double acceleration_after = 0;

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      //print(event);
      double difference = acceleration_x_before - event.x;
      print("Difference: " + difference.toString());
      if( difference.abs() > limit_of_operation){
        setState(() {
          this.color = colorGenerator.generate();
        });
      }
      acceleration_x_before = event.x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hey there',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: colorGenerator.secondColor(),
                        fontSize: 28.0,
                      )
                    ),
                  )
                ],
              ),
            ),
            decoration: new BoxDecoration(color: Color.fromRGBO(color.red, color.green, color.blue, color.opacity)),
      ),
          onTap: () {
            setState(() {
              this.color = colorGenerator.generate();
            });
          },
    );
  }
}

class ColorGenerator{
  Color _firstColor;
  // RGB have 24 bits color then it is 16777216 color capabilities
  ColorGenerator(){
    _firstColor = Colors.white;
  }

  Color generate(){
    var rng = new Random();
    int red = rng.nextInt(256);
    int green = rng.nextInt(256);
    int blue = rng.nextInt(256);
    Color color = Color.fromRGBO(red, green, blue, 1.0);
    print("R: $red G: $green B: $blue ");
    _firstColor = color;
    return color;
  }

  Color secondColor(){
    if(_firstColor.red >= 128 && _firstColor.green >= 128 && _firstColor.blue >= 128){
      return Colors.black;
    }
    else{
      return Colors.white;
    }
  }
}