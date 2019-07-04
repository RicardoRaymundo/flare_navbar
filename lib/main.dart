import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'menu_animated_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Container(color: Colors.black, child: Center(child: NavBar()))),
    );
  }
}

class NavBar extends StatefulWidget {
  createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  //Lista de objetos tipo MenuAnimatedItem que serao exibidos na NavBar.
  //Os itens da Navbar estão sendo criados atravez do contrutor da classe
  // MenuAnimatedItem. Estes tem cor, posicao no eixo x e nome.
  //O nome será usado posteriormente para indicar o arquivo Flare (.flr)
  // correspondente.
  List items = [
    MenuAnimatedItem(x: -1.0, name: 'house', color: Colors.lightBlue[100]),
    MenuAnimatedItem(x: -0.5, name: 'planet', color: Colors.purple),
    MenuAnimatedItem(x: 0.0, name: 'camera', color: Colors.greenAccent),
    MenuAnimatedItem(x: 0.5, name: 'heart', color: Colors.pink),
    MenuAnimatedItem(x: 1.0, name: 'head', color: Colors.yellow),
  ];

  //variavel usada para guardar o valor do item indicado
  MenuAnimatedItem active;

  @override
  void initState() {
    super.initState();
    //setando a posicão inicial da barra indicadora da NavBar
    active = items[0];
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      color: Colors.black,
      child: Stack(
        children: [
          AnimatedContainer(
            //Barra indicadora animada da navBar
            duration: Duration(milliseconds: 200),
            alignment: Alignment(active.x, -1),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 8,
              width: w * 0.2,
              color: active.color, //cor do objeto da lista atualmente indicado
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: items.map((k) { //mapeando os itens da lista na Row
                return _flare(k);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _flare(MenuAnimatedItem item) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: FlareActor(
            'assets/${item.name}.flr', //gif guardado na pasta assets
            alignment: Alignment.center,
            fit: BoxFit.contain, //faz a imagem se encaixar no widget pai
            animation: item.name == active.name ? 'go' : 'idle',
          ),
        ),
      ),
      onTap: () {
        setState(() {
          //função que seta o item atual durante a aplicação
          active = item;
        });
      },
    );
  }
}
