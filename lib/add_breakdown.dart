import 'package:flutter/material.dart';

import 'parser.dart';

class AddBreakdown extends StatelessWidget{
  AddBreakdown({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Breakdown"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      body: Column(
        children: <Widget>[
          Display(),
          Keyboard(),
        ],
      ),
    );
  }
}

var _displayState = DisplayState();

class Display extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _displayState;
  }
}

class DisplayState extends State<Display> {
  var _expression = '';
  var _result = '';

  @override
  Widget build(BuildContext context) {
    var views = <Widget>[
      Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    _expression,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ))
            ],
          )),
    ];

    if (_result.isNotEmpty) {
      views.add(Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                    _result,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ))
            ],
          )),
      );
    }

    return Expanded(
        flex: 2,
        child: Container(
          color: Theme
              .of(context)
              .primaryColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: views,
          ),
        ));
  }
}

void _addKey(String key) {
  var _expr = _displayState._expression;
  var _result = '';
  if (_displayState._result.isNotEmpty) {
    _expr = '';
    _result = '';
  }

  if (operators.contains(key)) {
    // Handle as an operator
    if (_expr.length > 0 && operators.contains(_expr[_expr.length - 1])) {
      _expr = _expr.substring(0, _expr.length - 1);
    }
    _expr += key;
  } else if (digits.contains(key)) {
    // Handle as an operand
    _expr += key;
  } else if (key == 'C') {
    // Delete last character
    if (_expr.length > 0) {
      _expr = _expr.substring(0, _expr.length - 1);
    }
  } else if (key == '=') {
    try {
      var parser = const Parser();
      _result = parser.parseExpression(_expr).toString();
    } on Error {
      _result = 'Error';
    }
  }
  // ignore: invalid_use_of_protected_member
  _displayState.setState(() {
    _displayState._expression = _expr;
    _displayState._result = _result;
  });
}

class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Center(
            child:
            AspectRatio(
              aspectRatio: 1.0, // To center the GridView
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: <String>[
                  // @formatter:off
                  '7', '8', '9', '/',
                  '4', '5', '6', '*',
                  '1', '2', '3', '-',
                  'C', '0', '=', '+',
                  // @formatter:on
                ].map((key) {
                  return GridTile(
                    child: KeyboardKey(key),
                  );
                }).toList(),
              ),
            )
        ));
  }
}

class KeyboardKey extends StatelessWidget {
  KeyboardKey(this._keyValue);

  final _keyValue;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        _keyValue,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26.0,
          color: Colors.black,
        ),
      ),
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      onPressed: () {
        _addKey(_keyValue);
      },
    );
  }
}