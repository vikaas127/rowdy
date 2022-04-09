import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearProgressIndicatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState extends State<LinearProgressIndicatorApp> {
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.2;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: LinearProgressIndicator(
        backgroundColor: Colors.white,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
    value: _progressValue,
    ),),
    );
  }
  // this function updates the progress value
  void updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.1;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return;
        }
      });
    });
  }
}