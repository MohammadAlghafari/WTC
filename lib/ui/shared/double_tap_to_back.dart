import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DoubleBackToCloseApp extends StatefulWidget {
  final Widget child;

  const DoubleBackToCloseApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _DoubleBackToCloseAppState createState() => _DoubleBackToCloseAppState();
}

class _DoubleBackToCloseAppState extends State<DoubleBackToCloseApp> {
  DateTime? _lastTimeBackButtonWasTapped;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  bool get _isFlutterToastVisible {
    final lastTimeBackButtonWasTapped = _lastTimeBackButtonWasTapped;
    return (lastTimeBackButtonWasTapped != null) &&
        (const Duration(seconds: 2) >
            DateTime.now().difference(lastTimeBackButtonWasTapped));
  }

  bool get _willHandlePopInternally =>
      ModalRoute.of(context)?.willHandlePopInternally ?? false;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    if (_isFlutterToastVisible || _willHandlePopInternally) {
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now();
      flutterToast('press_again_to_close_app'.tr);

      return false;
    }
  }

  flutterToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
        fontSize: 14);
  }
}
