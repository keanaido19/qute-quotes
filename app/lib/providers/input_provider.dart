import 'package:flutter/cupertino.dart';

class InputProvider with ChangeNotifier {
  String _text = '';
  String? _name;

  bool get isTrue => _text == '';

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

  void reset() {
    _text = '';
    _name = null;
  }
}