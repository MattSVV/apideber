import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appi/models/Gif.dart';
import 'package:http/http.dart' as http;

String urlString = "https://api.giphy.com/v1/gifs/trending?api_key=DdZnUo8SHxJWJtWsebPLDCxlt6MFtdwV&limit=10&offset=0&rating=g&bundle=messaging_non_clips";
Uri uri = Uri.parse(urlString);
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  


  late Future<List<Gif>> _listadoGifs;

  Future<List<Gif>> _getGifs() async{


    final response = await http.get(uri);
    
    List<Gif> ninivideo = [];

    if(response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);

      final jsondata = jsonDecode(body);

      for (var item in jsondata["data"]) {
        ninivideo.add(
          Gif(name: item["title"], url: item["images"]["fixed_height_small"]["url"]));
      }

    }else{
      Exception("Fallo en la coneccion");
    }

    return ninivideo;
  }

  @override
  void initState(){
    super.initState();
    _listadoGifs = _getGifs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola Mundo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hola Mundo App'),
        ),
        body: Center(
          child: Text(
            '¡Hola Mundo!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

