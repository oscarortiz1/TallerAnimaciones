import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:multipantallas/main.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class Information extends StatefulWidget {
  final Map serie;

  Information({Key key, this.serie}) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  Map serie = new Map();
  Widget expancionText = CircularProgressIndicator();

  int enteroBarra = 0;
  evento() {
    const oneSec = const Duration(seconds: 1);
    Timer _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (enteroBarra>=100) {
            timer.cancel();
            return;
          }else{
         
          enteroBarra += timer.tick;}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    serie = widget.serie;
    _crearLista(1);
    return new Scaffold(
        body: OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Center(
                        child: Column(children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(this.serie["nombre"]),
                            Text(this.serie["descripcion"]),
                            Text(this.serie["genero"]),
                            Text(this.serie["actores"]),
                          ],
                        ),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: SingleChildScrollView(
                            child: Container(
                          child: Column(
                            children: [
                              enteroBarra >= 100
                                ? (_creartemporadas())
                                : Center(
                                    child: FAProgressBar(
                                        currentValue: enteroBarra,
                                        maxValue: 100,
                                        displayText: '%',
                                        animatedDuration:
                                            Duration(seconds: 5))),
                              enteroBarra >= 100?
                              this.expancionText:Container()
                            ],
                          ),
                        )),
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('REGRESAR'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                      ),
                    ],
                  ),
                ])))));
      } else {
        evento();
        return SingleChildScrollView(
            child: Row(children: [
          Image.network(
            serie["imagen"].toString(),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
          ),
          Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: SingleChildScrollView(
                  child: Center(
                      child: Column(children: [
                GradientCard(
                    gradient: Gradients.tameer,
                    shadowColor: Gradients.tameer.colors.last.withOpacity(0.25),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(this.serie["nombre"]),
                          Text(this.serie["descripcion"]),
                          Text(this.serie["genero"]),
                          Text(this.serie["actores"]),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: Text('Anterior'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: GradientCard(
                      gradient: Gradients.tameer,
                      shadowColor:
                          Gradients.tameer.colors.last.withOpacity(0.25),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: SingleChildScrollView(
                          child: Container(
                        child: Column(
                          children: [
                            enteroBarra >= 100
                                ? (_creartemporadas())
                                : Center(
                                    child: FAProgressBar(
                                        currentValue: enteroBarra,
                                        maxValue: 100,
                                        displayText: '%',
                                        animatedDuration:
                                            Duration(seconds: 5))),
                                 enteroBarra >= 100?
                              this.expancionText:Container()
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              ]))))
        ]));
      }
    }));
  }

  Widget _creartemporadas() {
    List<Widget> buttons = new List<Widget>();
    for (var i = 1; i < this.serie["temporada"] + 1; i++) {
      buttons.add(
        RaisedButton(
          onPressed: () {
            _crearLista(i);
          },
          padding: EdgeInsets.all(10.0),
          child:
              Text("Temporada " + i.toString(), style: TextStyle(fontSize: 20)),
        ),
      );
    }
    return SingleChildScrollView(
      child: Row(children: buttons),
      scrollDirection: Axis.horizontal,
    );
  }

  void _crearLista(int it) {
    var rng = new Random();
    List<Widget> buttons = new List<Widget>();
    for (var i = 1; i <= serie["numeroepisodios"]; i++) {
      buttons.add(ExpansionTile(
        title: Text(serie["nombre"] +
            " Season" +
            it.toString() +
            " capitulo " +
            i.toString()),
        children: [
          Text(
              "Ver películas es una buena manera de entretenerse. Existe una gran variedad de largometrajes en la actualidad, de diferentes estilos, por lo que no siempre es fácil elegir cuál queremos ver. La diversidad de tipos de películas alimenta nuestra imaginación. Una película de miedo, una de aventuras o una comedia, todas ellas nos hacen sentir distintas emociones que enriquecen nuestras vidas.")
        ],
      ));
    }

    setState(() {
      this.expancionText = SingleChildScrollView(
          child: Column(
        children: buttons,
      ));
    });
  }
}
