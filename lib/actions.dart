import 'dart:math';
import 'package:flutter/material.dart' hide Action;
import 'package:thoughtspeech/buttons.dart';
import 'main.dart';
import 'dictionary.dart';

String _currentVoiceText = "";

class ActionsPage extends StatefulWidget {
  const ActionsPage({Key? key, required this.voiceText, required this.setTextValue})
      : super(key: key);
  final String voiceText;
  final ValueChanged<String> setTextValue;
  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  void _handleTextUpdate(String value) {
    setState(() {
      _currentVoiceText = value;
      widget.setTextValue(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentVoiceText = widget.voiceText;
  }

  void actionButtonPressed(Action input, BuildContext context) {
    //Rellly really hope that everything is passed by reference otherwise im screwed with frequencies
    input.freq++;
    List<String> forms = input.conjugate();
    //TODO: make this dialog better bc thats what the judges said we should
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .6,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: forms.length,
                  itemBuilder: ((context, index) {
                    return TextButton(
                        child: Text(forms[index]),
                        onPressed: () {
                          _handleTextUpdate(_currentVoiceText + " " + forms[index]);
                          Navigator.pop(context, true);
                        });
                  })),
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Actions")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          globalVars.tts.speak(_currentVoiceText);
        },
        heroTag: 'readaloudbtn',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.record_voice_over),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //text box with words to speak
          Center(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .15,
                  child: Center(child: Text(_currentVoiceText)),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Visibility(
                  visible: _currentVoiceText != "",
                  child: Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _handleTextUpdate("");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _height * .045),
          SizedBox(
            height: _height * .7,
            child: ListView.builder(
              itemCount: actions.length ~/ 7,
              itemBuilder: ((context, int index) {
                actions.sort();
                List<Action> labels = actions.sublist(index * 7, (index + 1) * 7);
                double height = MediaQuery.of(context).size.height;
                double width = MediaQuery.of(context).size.width * .9;
                double _defaultHeight = height / 6.7;
                double _defaultWidth = width / 2.05;
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //labels[0]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[0],
                                  actionButtonPressed: actionButtonPressed),
                              //Use sized boxes for whitespace, not containers
                              SizedBox(height: height * .05),
                              //labels[1]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[1],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[2]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[2],
                                  actionButtonPressed: actionButtonPressed),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //lables[3]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[3],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[4]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight,
                                  label: labels[4],
                                  actionButtonPressed: actionButtonPressed),
                              SizedBox(height: height * .05),
                              //labels[5]
                              ActionListButton(
                                  defaultWidth: _defaultWidth,
                                  defaultHeight: _defaultHeight * 2,
                                  label: labels[5],
                                  actionButtonPressed: actionButtonPressed),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .05),
                      //labels[6]
                      ActionListButton(
                          defaultWidth: _defaultWidth * 2.1,
                          defaultHeight: _defaultHeight,
                          label: labels[6],
                          actionButtonPressed: actionButtonPressed),
                      SizedBox(height: height * .05),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

class Action extends Comparable {
  final String name;

  Icon? icon;
  int freq = 0;
  Color color;

  Action({required this.name, this.icon, required this.color});

  @override
  String toString() {
    return name;
  }

  List<String> conjugate() {
    return verbsToConjugations[name]!;
  }

  bool hasIcon() {
    return (icon != null);
  }

  @override
  int compareTo(other) {
    if (freq > other.freq) {
      return -1;
    } else if (freq < other.freq) {
      return 1;
    }
    return 0;
  }
}
