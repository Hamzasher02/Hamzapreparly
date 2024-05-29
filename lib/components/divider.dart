import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttractiveDivider extends StatefulWidget {
  @override
  _AttractiveDividerState createState() => _AttractiveDividerState();
}

class _AttractiveDividerState extends State<AttractiveDivider>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late Timer _timer; // Declare a Timer variable

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); //  the "Timer" will be properly canceled when the widget is disposed, and the "setState() called after dispose()" error should be resolved.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 700),
      child: Container(
        width: double.infinity,
        height: 20,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          color: Colors.blueGrey.shade100,
          thickness: 4,
        ),
      ),
    );
  }
}
