import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multipantallas/information.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'taller multipantallas',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter taller multipantallas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> controlleranimations;
  Animation<Offset> imageTranslation;
  Animation<Offset> textTranslation;
  Animation<double> imageOpacity;
  Animation<double> textOpacity;
  @override
  void initState() {
    super.initState();
    controlleranimations = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  int temporadaseleccionada = 1;
  final List jsonSeries = [
    {
      "nombre": "Parasito",
      "imagen":
          "https://r2.abcimg.es/resizer/resizer.php?imagen=https%3A%2F%2Fstatic4.abc.es%2Fmedia%2Fpeliculas%2F000%2F054%2F285%2Fparasitos-1.jpg&nuevoancho=620&medio=abc",
      "numeroepisodios": 5,
      "descripcion":
          "Tanto Gi Taek como su familia están sin trabajo. Cuando su hijo mayor, Gi Woo, empieza a impartir clases particulares en la adinerada casa de los Park, las dos familias, que tienen mucho en común pese a pertenecer a dos mundos totalmente distintos, entablan una relación de resultados imprevisibles.",
      "temporada": 2,
      "genero": "drama",
      "actores": "Song Kang-ho,Lee Sun-kyun, etc"
    },
    {
      "nombre": "Spiderman",
      "imagen":
          "https://www.elgoldigital.com/wp-content/uploads/1566717212_191664_1566717436_noticia_normal.jpg",
      "numeroepisodios": 8,
      "descripcion":
          "Spider-Man es un superhéroe ficticio creado por los escritores y editores Stan Lee y Steve Ditko. Apareció por primera vez en el cómic de antología Amazing Fantasy # 15, en la Edad de Plata de los cómics.",
      "temporada": 3,
      "genero": "Accion",
      "actores": "Gwen Stacy, Betty Brant, etc"
    },
    {
      "nombre": "Como entrenar a tu dragon",
      "imagen":
          "https://es.web.img2.acsta.net/pictures/18/11/08/11/03/2583259.jpg",
      "numeroepisodios": 5,
      "descripcion":
          "Hipo, un vikingo adolescente, comienza las clases de entrenamiento con dragones y ve por fin una oportunidad para demostrar que es capaz de convertirse en guerrero cuando hace amistad con un dragón herido.",
      "temporada": 2,
      "genero": "Accion",
      "actores": "Chris Sanders, Dean DeBlois, etc"
    },
    {
      "nombre": "Forzen 2",
      "imagen":
          "https://es.web.img2.acsta.net/pictures/19/10/22/17/52/2684020.jpg",
      "numeroepisodios": 3,
      "descripcion":
          "Elsa tiene un poder extraordinario: es capaz de crear hielo y nieve. Sin embargo, a pesar de lo feliz que la hacen los habitantes de Arendelle, siente que no encaja allá. Después de oír una voz misteriosa, Elsa, acompañada por Anna, Kristoff, Olaf y Sven, viaja a los bosques embrujados y los mares oscuros que se extienden más allá de los límites de su reino para descubrir quién es en realidad y por qué posee un poder tan asombroso.",
      "temporada": 2,
      "genero": "Fantasia",
      "actores": "Jennifer Lee, Chris Buck, etc"
    },
    {
      "nombre": "Dumbo",
      "imagen":
          "https://es.web.img3.acsta.net/pictures/19/01/22/16/26/2486964.jpg",
      "numeroepisodios": 3,
      "descripcion":
          "El dueño de un circo en aprietos contrata a un hombre y sus dos hijos para cuidar de un elefante recién nacido que puede volar, que pronto se convierte en la atracción principal que revitaliza al circo.",
      "temporada": 2,
      "genero": "Familiar",
      "actores": "Tim Burton, etc"
    },
    {
      "nombre": "Detective pikachu",
      "imagen":
          "https://musicimage.xboxlive.com/catalog/video.movie.8D6KGWXMZDFC/image?locale=es-mx&mode=crop&purposes=BoxArt&q=90&h=225&w=150&format=jpg",
      "numeroepisodios": 3,
      "descripcion":
          "Un joven une fuerzas con el detective Pikachu para desentrañar el misterio detrás de la desaparición de su padre. El dúo dinámico descubre una trama tortuosa que representa una amenaza para el universo Pokémon..",
      "temporada": 2,
      "genero": "Fantasia",
      "actores": "Rob Letterman, etc"
    },
    {
      "nombre": "Shazam",
      "imagen": "https://miro.medium.com/max/2428/0*7X-lvJmQqN-dMtCe.jpeg",
      "numeroepisodios": 1,
      "descripcion":
          "Billy Batson, un astuto joven de 14 años, se transforma en el superhéroe Shazam, pero sus poderes son puestos a prueba cuando se enfrenta al mal.",
      "temporada": 1,
      "genero": "Accion",
      "actores": "Benjamin Wallfisch, etc"
    },
    {
      "nombre": "Alita Battle Angel",
      "imagen":
          "https://www.tonica.la/__export/1581383838050/sites/debate/img/2020/02/10/alita.jpg_554688468.jpg",
      "numeroepisodios": 1,
      "descripcion":
          "Alita es un cyborg que se despierta en la clínica de un médico sin recordar quién es. La cyborg deberá usar sus extraordinarias habilidades para combatir contra enemigos terribles, mientras trata de descubrir la verdad sobre su pasado.",
      "temporada": 1,
      "genero": "Accion",
      "actores": "James Camero, Jhon Landau, Robert Rodriguez, etc"
    },
    {
      "nombre": "historia de un matrimo",
      "imagen":
          "https://es.web.img3.acsta.net/pictures/19/10/18/09/47/2461540.jpg",
      "numeroepisodios": 1,
      "descripcion":
          "Un director de teatro y su mujer, actriz, luchan por superar un divorcio que les lleva al extremo tanto en lo personal como en lo creativo.",
      "temporada": 1,
      "genero": "Accion",
      "actores": "Noah Baumbach, Robert Rodriguez, etc"
    },
    {
      "nombre": "Nosotros",
      "imagen": "https://www.ecartelera.com/carteles/14200/14210/003_m.jpg",
      "numeroepisodios": 3,
      "descripcion":
          "Adelaide y su esposo viajan a la casa en la que ella creció junto a la playa. Tiene un presentimiento siniestro que precede a un encuentro espeluznante: cuatro enmascarados se presentan ante su casa. Lo aterrador viene cuando muestran sus rostros.",
      "temporada": 2,
      "genero": "Accion",
      "actores": "Jordan Peele, etc"
    }
  ];
  Widget serieselecionada = Container(
    child: Text("Buscar:"),
    alignment: Alignment.center,
  );
  @override
  Widget build(BuildContext context) {
    var hasDetailPage =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var child;

    // 6
    child = _crearlistaseries(context, hasDetailPage);

    return Scaffold(
        body: SafeArea(
      // 7
      child: child,
    ));
  }

  _crearlistaseries(BuildContext context, bool hasDetailPage) {
    imageTranslation = Tween(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controlleranimations,
        curve: Interval(0.0, 0.67, curve: Curves.fastOutSlowIn),
      ),  
    );
    imageOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controlleranimations,
        curve: Interval(0.0, 0.67, curve: Curves.easeIn),
      ),
    );
    textTranslation = Tween(
      begin: Offset(0.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: controlleranimations,
        curve: Interval(0.34, 0.84, curve: Curves.ease),
      ),
    );
    textOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controlleranimations,
        curve: Interval(0.34, 0.84, curve: Curves.linear),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              children: [
                Icon(Icons.search),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'series '),
                  ),
                )
              ],
            ),
          ),
        ),
        body: GridView.count(
            crossAxisCount: hasDetailPage ? 4 : 2,
            children: List.generate(jsonSeries.length, (index) {
              return AnimatedBuilder(
                animation: controlleranimations,
                builder: (BuildContext context, Widget child) {
                  return GestureDetector(
                      child: Container(
                        height: 50,
                        child: Card(
                            child: Column(
                          children: <Widget>[
                            FractionalTranslation(
                              translation: imageTranslation.value,
                              child: Image.network(
                                jsonSeries[index]["imagen"],
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            ),
                            Expanded(
                              child: FractionalTranslation(
                                translation: textTranslation.value,
                                child: Text(jsonSeries[index]["nombre"]),
                              ),
                            ),
                            SizedBox(height: 34.0),
                          ],
                        )),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secanimation,
                                    Widget child) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                    alignment: Alignment.center,
                                  );
                                },
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secanimation) {
                                  return Information(
                                    serie: jsonSeries[index],
                                  );
                                }));
                      });
                },
                child: GestureDetector(
                    child: Container(
                      height: 50,
                      child: Card(
                          child: Column(
                        children: <Widget>[
                          Image.network(
                            jsonSeries[index]["imagen"],
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                          Expanded(
                            child: Text(jsonSeries[index]["nombre"]),
                          ),
                          SizedBox(height: 34.0),
                        ],
                      )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secanimation,
                                  Widget child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                  alignment: Alignment.center,
                                );
                              },
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secanimation) {
                                return Information(
                                  serie: jsonSeries[index],
                                );
                              }));
                    }),
              );
            })));
  }
}
