import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url as Uri);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
    });

    print("Resultado : " + retorno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _preco,
                  style: TextStyle(fontSize: 35),
                ),
              ),
              InkWell(
                onTap: () {
                  _recuperarPreco();
                },
                child: Container(
                  height: 60,
                  width: 30,
                  child: Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
