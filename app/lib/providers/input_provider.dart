import 'package:flutter/cupertino.dart';

class InputProvider with ChangeNotifier {
  String _text = '';
  String? _name;
  bool _submitted = false;

  bool get isTextEmpty => _text == '';

  bool get isTextEmptyAndTriedSubmit => (_text == '') & _submitted;

  String get getText => _text;

  String? get getName => _name;

  void setText(String text) {
    _text = text;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setSubmitted() {
    _submitted = true;
    notifyListeners();
  }

  void reset() {
    _text = '';
    _name = null;
    _submitted = false;
  }
}