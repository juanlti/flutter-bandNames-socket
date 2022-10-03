import 'dart:io';

import 'package:first_app_sockets/src/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(idP: '1', nameP: 'LasPalmeres', votesP: 5),
    Band(idP: '2', nameP: 'New Orden', votesP: 1000),
    Band(idP: '3', nameP: 'Los Piojes', votesP: 200),
    Band(idP: '4', nameP: 'Kumba 420', votesP: 10),
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onPressFloactActionButton,
      ),
      appBar: AppBar(
        title: Center(child: Text('/////////// Bands ///////////')),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          //return Text('Hola Mundo ${bands[index].name} ultimo index $index');
          Band aBand = bands[index];
          return _bandTitle(aBand);
        },
      ),
    );
  }

  Widget _bandTitle(Band aBand) {
    return Dismissible(
        crossAxisEndOffset: 0.6,
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Borrar ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        movementDuration: const Duration(seconds: 1),
        resizeDuration: const Duration(seconds: 1),
        direction: DismissDirection.startToEnd,
        //onDismissed sirve para saber que borre
        onDismissed: (direction) {
          print('QUE SELECIONE CON DIRRECCION ? ${direction.name}');
          //'OTRO FORMA ES CON EL ARGUMENTO PASADA POR PARAMETRO, LA BAND
          print('QUE SELECIONE CON BANDA ? ${aBand.name}');
        },
        key: Key(aBand.id),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(
              aBand.name.substring(0, 2),
            ),
          ),
          trailing: Text('${aBand.votes}'),
          title: Text(aBand.name),
          onTap: () {
            print('banda selecionada ==>${aBand.name}');
          },
        ));
  }

  onPressFloactActionButton() {
    final TextEditingController textController = TextEditingController();

    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextField(
              controller: textController,
            ),
            title: Text('Agregar nueva banda musical ANDDROID'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No guardar')),
              TextButton(
                  onPressed: () {
                    print('contenido de "guardar ==> ${textController.text}');
                    onPressFloactActionButtonAddButton(
                        nameNew: textController.text);
                    Navigator.pop(context);
                  },
                  child: Text('Guardar')),
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
                title: Text('Agregar nueva banda musical IOS'),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: Text('No guardar'),
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('Guardar'),
                    isDefaultAction: true,
                    onPressed: (() {
                      onPressFloactActionButtonAddButton(
                          nameNew: textController.text);

                      Navigator.pop(context);
                    }),
                  ),
                ]);
          });
    }
  }

  void onPressFloactActionButtonAddButton({required String nameNew}) {
    if (nameNew.length > 1) {
      setState(() {});
      Band x = Band(idP: '${bands.length + 1}', nameP: nameNew, votesP: 5);
      bands.add(x);
    }
  }
}
