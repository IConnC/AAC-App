import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';

// Possibility to count number of times used and order the list based on frequency of use
// This needs to be divisible by 7 or it goes poorly
Map<String, List<String>> verbsToConjugations = {
  'be': ['am', 'are', 'is', 'was', 'were', 'being', 'been', 'to be', 'be'],
  'have': ['have', 'has', 'had', 'having', 'to have'],
  'do': ['do', 'does', 'did', 'doing', 'done', 'to do'],
  'say': ['say', 'says', 'said', 'saying', 'to say'],
  'get': ['get', 'gets', 'got', 'getting', 'gotten', 'to get'],
  'make': ['make', 'makes', 'made', 'making', 'to make'],
  'go': ['go', 'goes', 'went', 'going', 'gone', 'to go'],
  'know': ['know', 'knows', 'knew', 'knowing', 'known', 'to know'],
  'take': ['take', 'takes', 'took', 'taking', 'taken', 'to take'],
  'see': ['see', 'sees', 'saw', 'seeing', 'seen', 'to see'],
  'come': ['come', 'comes', 'came', 'coming', 'to come'],
  'think': ['think', 'thinks', 'thought', 'thinking', 'to think'],
  'look': ['look', 'looks', 'looked', 'looking', 'to look'],
  'want': ['want', 'wants', 'wanted', 'wanting', 'to want'],
  'give': ['give', 'gives', 'gave', 'giving', 'given', 'to give'],
  'use': ['use', 'uses', 'used', 'using', 'to use'],
  'find': ['find', 'finds', 'found', 'finding', 'to find'],
  'tell': ['tell', 'tells', 'told', 'telling', 'to tell'],
  'ask': ['ask', 'asks', 'asked', 'asking', 'to ask'],
  'work': ['work', 'works', 'worked', 'working', 'to work'],
  'seem': ['seem', 'seems', 'seemed', 'seeming', 'to seem'],
  'feel': ['feel', 'feels', 'felt', 'feeling', 'to feel'],
  'try': ['try', 'tries', 'tried', 'trying', 'to try'],
  'leave': ['leave', 'leaves', 'left', 'leaving', 'to leave'],
  'call': ['call', 'calls', 'called', 'calling', 'to call']
};
List<Action> actions = [
  Action(name: "be"),
  Action(name: "have"),
  Action(name: "do"),
  Action(name: "say"),
  Action(name: "get"),
  Action(name: "make"),
  Action(name: "go"),
  Action(name: "know"),
  Action(name: "take"),
  Action(name: "see"),
  Action(name: "come"),
  Action(name: "think"),
  Action(name: "look"),
  Action(name: "want"),
  Action(name: "give"),
  Action(name: "use"),
  Action(name: "find"),
  Action(name: "tell"),
  Action(name: "ask"),
  Action(name: "work"),
  Action(name: "seem"),
  Action(name: "feel"),
  Action(name: "try"),
  Action(name: "leave"),
  Action(name: "call"),
];
/* Action(name: "Watch TV", icon: const Icon(Icons.tv)),
  Action(name: "Dance"),
  Action(name: "Turn on", icon: const Icon(Icons.power)),
  Action(name: "Turn off", icon: const Icon(Icons.power_off)),
  Action(name: "Win", icon: const Icon(Icons.emoji_events)),
  Action(name: "Fly", icon: const Icon(Icons.flight)),
  Action(name: "Cut", icon: const Icon(Icons.cut)),
  Action(name: "Throw away", icon: const Icon(Icons.delete)),
  Action(name: "Close", icon: const Icon(Icons.close)),
  Action(name: "Open"),
  Action(name: "Write", icon: const Icon(Icons.edit)),
  Action(name: "Give"),
  Action(name: "Jump"),
  Action(name: "Drink", icon: const Icon(Icons.local_cafe)),
  Action(name: "Cook"),
  Action(name: "Wash", icon: const Icon(Icons.wash)),
  Action(name: "Wait", icon: const Icon(Icons.hourglass_top)),
  Action(name: "Climb"),
  Action(name: "Talk", icon: const Icon(Icons.record_voice_over)),
  Action(name: "Crawl"),
  Action(name: "Dream"),
  Action(name: "Dig"),
  Action(name: "Clap"),
  Action(name: "Sew"),
  Action(name: "Smell"),
  Action(name: "Knit"),
  Action(name: "Kiss"),
  Action(name: "Hug"),
  Action(name: "Snore"),
  Action(name: "Bathe", icon: const Icon(Icons.shower)),
  Action(name: "Bow"),
  Action(name: "Paint", icon: const Icon(Icons.brush)),
  Action(name: "Dive"),
  Action(name: "Ski", icon: const Icon(Icons.pool)),
  Action(name: "Ski", icon: const Icon(Icons.downhill_skiing)),
  Action(name: "Stack"),
  Action(name: "Buy"),
  Action(name: "Shake", icon: const Icon(Icons.handshake)),
]; */
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
          Container(height: _height * .045),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  actionButtonPressed(labels[0], context);
                                },
                                child: (labels[0].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[0].icon!,
                                          Text(
                                            labels[0].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[0].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight * 2,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => actionButtonPressed(labels[1], context),
                                child: (labels[1].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[1].icon!,
                                          Text(
                                            labels[1].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[1].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => actionButtonPressed(labels[2], context),
                                child: (labels[2].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[2].icon!,
                                          Text(
                                            labels[2].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[2].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: _defaultWidth,
                              height: _defaultHeight,
                              child: TextButton(
                                onPressed: () => actionButtonPressed(labels[3], context),
                                child: (labels[3].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[3].icon!,
                                          Text(
                                            labels[3].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[3].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => actionButtonPressed(labels[4], context),
                                child: (labels[4].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[4].icon!,
                                          Text(
                                            labels[4].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[4].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                            Container(height: height * .05),
                            Container(
                              width: _defaultWidth,
                              height: _defaultHeight * 2,
                              decoration: BoxDecoration(
                                color: randomColor(),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => actionButtonPressed(labels[5], context),
                                child: (labels[5].hasIcon())
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          labels[5].icon!,
                                          Text(
                                            labels[5].toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        labels[5].toString(),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.onBackground),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(height: height * .05),
                    Container(
                      width: _defaultWidth * 2.1,
                      height: _defaultHeight,
                      decoration: BoxDecoration(
                        color: randomColor(),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () => actionButtonPressed(labels[6], context),
                        child: (labels[6].hasIcon())
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  labels[6].icon!,
                                  Text(
                                    labels[6].toString(),
                                    style:
                                        TextStyle(color: Theme.of(context).colorScheme.onBackground),
                                  ),
                                ],
                              )
                            : Text(
                                labels[6].toString(),
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                              ),
                      ),
                    ),
                    Container(height: height * .05),
                  ],
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

  Action({required this.name, this.icon});

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
