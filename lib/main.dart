import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controlePeso = TextEditingController();
  TextEditingController controleAltura = TextEditingController();
  String _textoInfo = "Informe seus Dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limpaFormulario() {
    controlePeso.text = "";
    controleAltura.text = "";
    setState(() {
      _textoInfo = "Informe seus Dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaIMC() {
    setState(() {
      double peso = double.parse(controlePeso.text);
      double altura = double.parse(controleAltura.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _textoInfo = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textoInfo = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textoInfo = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textoInfo = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textoInfo = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _textoInfo = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _limpaFormulario();
            }
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child:
          Form(
            key: _formKey,
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green
                  ),
                  TextFormField(
                    controller: controlePeso,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    controller: controleAltura,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child:
                    Container(
                        height: 50.0,
                        child:
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculaIMC();
                            }
                          },
                          child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          color: Colors.green,
                        )
                    )
                  ),
                  Text(
                    _textoInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
          )
      )
    );
  }
}
