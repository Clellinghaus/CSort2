import 'package:flutter/material.dart';
import 'package:csort/board.dart';
import 'package:csort/legend.dart';

void main() {
  runApp(const MyApp());
}

//MyApp ist das GrundLayout der App
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool nightmode = false;
  get child => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSort',

      //wenn nightmode aktiviert ist wird ThemeData.dark gewwaehlt
      theme: (nightmode
          ? ThemeData(
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.grey,
            )),
      home: Scaffold(
        //AppBar mit Logo und Text und Zwei Icons und einem SwitchButton um den Darkmode einzustellen
        appBar: AppBar(
          centerTitle: true,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/Logo_CSort.png', height: 40)),
            const Text('CSort')
          ]),
          actions: <Widget>[
            const Icon(
              Icons.wb_sunny,
            ),
            Switch(
                value: nightmode,
                onChanged: (value) {
                  setState(() {
                    nightmode = value;
                  });
                }),
            const Icon(
              Icons.nightlight_round,
            ),
          ],
        ),
        //Das eigentliche Board liegt in board.dart
        body: const Board(),
        //Die untere Leiste ist eine Legende siehe legende.dart
        bottomNavigationBar: const Legend(),
      ),
    );
  }
}
