import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infoText = "";
  String valorSelecionado = "";
  String valorSelecionado2 = "";



  void _resetFields(){
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "";
    });
  }
  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);

      double salarios = weight;

      if(salarios >= 1 && salarios < 2 && valorSelecionado == 'dois_filhos' && valorSelecionado2 == "acompanhada"){
        _infoText = "Auxílio de 1,5 salário mínimo";
      }
      else if(salarios < 1 && valorSelecionado == 'dois_filhos' && valorSelecionado2 == "acompanhada"){
        _infoText = "Auxílio de 2,5 salários mínimos";
      }else if(valorSelecionado == 'tres_filhos' && valorSelecionado2 == "acompanhada"){
        _infoText = "Auxílio de 3 salários mínimos.";
      }
      else if(salarios >= 1 && salarios < 2 && valorSelecionado == 'dois_filhos' && valorSelecionado2 == "solteira") {
        _infoText = "Auxílio de 1,5 salário mínimo + 600,00 reais";
      }else if(salarios < 1 && valorSelecionado == 'dois_filhos' && valorSelecionado2 == "solteira"){
        _infoText = "Auxílio de 2,5 salários mínimos + 600,00 reais";
      }else if(valorSelecionado == 'tres_filhos' && valorSelecionado2 == "solteira") {
        _infoText = "Auxílio de 3 salários mínimos + 600,00 reais";
      }else {
        _infoText = "Sem auxilio";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Calculadora Auxilio"),
        centerTitle: true,
        backgroundColor: Colors.green,

        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Quantidade de salarios minimos:",
                    labelStyle: TextStyle(color:
                    Colors.green),


                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),

                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty){
                    return "Insira quantos salarios minimos voce ganha:";
                  } else if(double.parse(value) < 0){
                    return "Informe um número positivo!";
                  }
                },
              ),
              DropdownButton(
                onChanged: (value){

                  valorSelecionado = value.toString();
                },
                items: [
                  DropdownMenuItem(child: Text("Ate dois filhos na escola e vacinados"), value: 'dois_filhos',),
                  DropdownMenuItem(child: Text("Mais de 3 filhos na escola e vacinados"), value: 'tres_filhos', ),
                  DropdownMenuItem(child: Text("filho(s) fora da escola ou sem vacina"), value: 'irregular_filhos', ),


                ],
                iconEnabledColor: Colors.green,
                isExpanded: true,

              ),
              DropdownButton(
                onChanged: (value){

                  valorSelecionado2 = value.toString();
                },
                items: [
                  DropdownMenuItem(child: Text("mae solteira"), value: 'solteira',),
                  DropdownMenuItem(child: Text("mae acompanhada"), value: 'acompanhada', ),

                ],
                iconEnabledColor: Colors.green,
                isExpanded: true,

              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 50.0,

                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate() )
                        _calculate();
                    },
                    child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(
                "$_infoText", style: TextStyle(color: Colors.green, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
