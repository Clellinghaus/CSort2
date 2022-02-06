import 'package:flutter/material.dart';

//Untere Leiste der App
class Legend extends StatefulWidget {
  const Legend({Key? key}) : super(key: key);
  @override
  State<Legend> createState() => _LegendState();
}

class _LegendState extends State<Legend> {
  var color1 = "";
  var color2 = "";
  var color3 = "";
  var color4 = "";
  var color5 = "";
  var color6 = "";
  var color7 = "";

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //Es werden die einzelnen Farben nur angezeigt wenn Text dazu eingegeben wurde
      //Deswegen wird hier conditionaling rendering mit dem ?-Operator verwendet
      child: Row(
        children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    const Text(
                      'Legende:',
                      style: TextStyle(fontSize: 15),
                    ),
                    color1.isNotEmpty
                        ? Row(children: [
                            showRoundButton(Colors.white),
                            Text(color1)
                          ])
                        : Row(children: []),
                    color2.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFF7ABB5B)),
                            Text(color2)
                          ])
                        : Row(children: []),
                    color3.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFFF3EB72)),
                            Text(color3)
                          ])
                        : Row(children: []),
                    color4.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFFF08586)),
                            Text(color4)
                          ])
                        : Row(children: []),
                    color5.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFFA47BB5)),
                            Text(color5)
                          ])
                        : Row(children: []),
                    color6.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFF459AD5)),
                            Text(color6)
                          ])
                        : Row(children: []),
                    color7.isNotEmpty
                        ? Row(children: [
                            showRoundButton(const Color(0xFF61C2CC)),
                            Text(color7)
                          ])
                        : Row(children: []),
                  ]))),
          //Runder Button um die Legende zu bearbeiten
          Container(
              margin: const EdgeInsets.all(5),
              child: FloatingActionButton(
                mini: true,
                tooltip: 'Add',
                child: const Icon(Icons.add),
                onPressed: () => showCustomDialog(context),
              )),
        ],
      ),
    );
  }

//der Dialog der angezeigt wird, besteht aus mehreren Buttons und TextFields
//Buttons machen nichts wenn man sie drückt
  void showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Legende erst ellen'),
            content: Column(children: [
              Row(children: [
                showRoundButton(Colors.white),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color1 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFF7ABB5B)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color2 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFFF3EB72)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color3 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFFF08586)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color4 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFFA47BB5)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color5 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFF459AD5)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color6 = text;
                    });
                  },
                ))
              ]),
              Row(children: [
                showRoundButton(const Color(0xFF61C2CC)),
                Expanded(child: TextField(
                  onChanged: (text) {
                    setState(() {
                      color7 = text;
                    });
                  },
                ))
              ])
            ]));
      });

//Button generator
  showRoundButton(Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {});
      },
      child: const Text(''),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
