import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

typedef MyCallback = void Function(Offset foo);

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);
  @override
  State<Board> createState() => _BoardState();
}

//cards state besteht aus einem Text, Color, bool isHeadline und einem bool das zeigt ob es auf dem linken oder rechten board liegt
//tmptext und tmpColor werden für die eingabe der karten verwendet
//in image wird das bild abgelegt
//off wird benötigt für drag and drop
//standard offset ist 300 und 56 weil appbar ist 56px hoch und die rechte boardhälfte ist 300 breit
class _BoardState extends State<Board> {
  var cards = [];
  var tmptext = "";
  var _image;
  Color tmpColor = Colors.white;
  Color caughtColor = Colors.grey;
  Offset off = Offset(-300, -56);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(children: <Widget>[
        //DragTarget wird für drag and drop benötigt
        //onaccept wird festgelegt was nach dem dropen auf dieses widget passiert
        DragTarget(
          onAccept: (int index) {
            var tmpCard = cards[index];
            tmpCard[3] = true;
            setState(() {
              cards[index] = tmpCard;
            });
          },
          builder: (BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            //linke seite des boards besteht aus drei texten und zwei buttons und zwei gridviews zum anzeigen der Karten und überschriften
            return Container(
                width: 300,
                color: caughtColor,
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Überschriften',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      height: 40,
                      width: 130,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () => showSimpleDialog(context, true),
                        child: const Text(''),
                      )),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Karten',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      height: 130,
                      width: 130,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () => showSimpleDialog(context, false),
                        child: const Text(''),
                      )),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: const Text(
                        'Ungeordnet',
                        style: TextStyle(fontSize: 20),
                      )),
                  Expanded(
                      child: GridView.count(
                          childAspectRatio: 3,
                          crossAxisCount: 2,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: getHeadlines(cards, setOffset))),
                  const Divider(
                    color: Colors.black,
                    indent: 20,
                    endIndent: 20,
                    thickness: 0.5,
                  ),
                  Expanded(
                      child: Stack(children: [
                    GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: getCards(cards, setOffset))
                  ]))
                ]));
          },
        ),
        //rechte seite des boards wird expanded damit es max. groß ist
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  image: (_image != null
                      ? DecorationImage(
                          image: MemoryImage(_image),
                          fit: BoxFit.fitHeight,
                        )
                      : null),
                ),
                //dragtarget für dnd
                child: DragTarget(onWillAccept: (data) {
                  int ind = data as int;
                  if (cards[ind][3] == true) return true;
                  return false;
                }, onAccept: (int index) {
                  var tmpCard = cards[index];
                  tmpCard[3] = false;
                  setState(() {
                    cards[index] = tmpCard;
                  });
                }, builder: (BuildContext context, List<dynamic> accepted,
                    List<dynamic> rejected) {
                  return (Stack(
                      children:
                          //hier werden die karten auf das board angezeigt
                          getCardsBoard(off, cards, setOffset, setImage)));
                })))
      ])
    ]);
  }

  void setOffset(Offset i) {
    setState(() {
      off = i;
    });
  }

  void setImage(var image) {
    setState(() {
      _image = image;
    });
  }

  //Dialog zum erstellen von karten /Überschrifen
  void showSimpleDialog(BuildContext context, bool isHeadline) => showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: (isHeadline
              ? const Text('Überschrift erstellen')
              : const Text('Karte erstellen')),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(7),
              child: TextField(
                  onChanged: (text) {
                    setState(() {
                      tmptext = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Hier Text schreiben',
                  )),
            ),
            Row(children: [
              showRoundButton(Colors.white),
              showRoundButton(const Color(0xFF7ABB5B)),
              showRoundButton(const Color(0xFFF3EB72)),
              showRoundButton(const Color(0xFFF08586)),
              showRoundButton(const Color(0xFFA47BB5)),
              showRoundButton(const Color(0xFF459AD5)),
              showRoundButton(const Color(0xFF61C2CC)),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleDialogOption(
                  child:
                      const Text('Abbrechen', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    tmptext = "";
                    tmpColor = Colors.white;
                    Navigator.pop(context);
                  },
                ),
                SimpleDialogOption(
                  child: const Text('Ok', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    setState(() {
                      cards.add([
                        tmptext,
                        tmpColor,
                        isHeadline,
                        true,
                      ]);
                    });
                    tmptext = "";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      });
//Button generator
  showRoundButton(Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          tmpColor = color;
        });
      },
      child: const Text(''),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

//linke seite des boards werden überschrifen angezeigt
  getHeadlines(List cards, setOffset) {
    var containers = <Widget>[];
    int tmpIndex = 0;
    cards.forEach((element) {
      if (element[3] && element[2]) {
        return containers.add(DragBox(const Offset(0.0, 0.0), element[0],
            element[1], element[2], tmpIndex++, setOffset));
      } else {
        tmpIndex++;
      }
    });

    return containers;
  }

//linke seite des boards werden karten angezeigt
  getCards(List cards, setOffset) {
    var containers = <Widget>[];
    int tmpIndex = 0;
    cards.forEach((element) {
      if (element[3] && !element[2]) {
        return containers.add(DragBox(const Offset(0.0, 0.0), element[0],
            element[1], element[2], tmpIndex++, setOffset));
      } else {
        tmpIndex++;
      }
    });
    return containers;
  }

//rechte seite des boards
  getCardsBoard(off, List cards, setOffset, setImage) {
    List containers = <Widget>[];
    int tmpIndex = 0;

    cards.forEach((element) {
      if (!element[3]) {
        return containers.add(DragBox(
            off, element[0], element[1], element[2], tmpIndex++, setOffset));
      } else {
        tmpIndex++;
        return;
      }
    });

//button zum hinzufügen eines hintergrunds
    containers.add(Container(
        margin: const EdgeInsets.all(5),
        child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                tooltip: 'Add',
                child: const Icon(Icons.add),
                mini: true,
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                  final fileBytes = result.files.first.bytes;
                  setImage(fileBytes);
                }))));
    return containers;
  }
}

//die karten/überschriften werden hier erzeugt als dragbox
class DragBox extends StatefulWidget {
  final Offset initPos;
  final String text;
  final Color itemColor;
  final bool headline;
  int index;
  final MyCallback callback;

  DragBox(this.initPos, this.text, this.itemColor, this.headline, this.index,
      this.callback,
      {Key? key})
      : super(key: key);

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position = const Offset(-300, -56);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    //mit positioned kann man flexibel festlegen wo das widget hin soll
    //mit left und right wird die position bestimmt
    return Positioned(
        left: position.dx - 300,
        top: position.dy - 56,
        //draggable für dnd
        child: Draggable(
          data: widget.index,
          child: Container(
            width: 100.0,
            height: (widget.headline ? 30 : 100.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              color: widget.itemColor,
            ),
            child: Center(
              child: Text(
                widget.text,
              ),
            ),
          ),
          //wird aufgerufen wenn draggable OHNE ein accept von einem dragTarget dedroppt wird
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              position = offset;
            });
          },

          //wird aufgerufen wenn draggable MIT ein accept von einem dragTarget dedroppt wird
          onDragEnd: (details) {
            widget.callback(details.offset);
          },
          feedback: Container(
            width: 120.0,
            height: (widget.headline ? 50 : 120.0),
            color: widget.itemColor.withOpacity(0.5),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ));
  }
}
