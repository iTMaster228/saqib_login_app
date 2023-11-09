import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<dynamic> _Results = [];
  List<dynamic> get Results => _Results;
  set Results(List<dynamic> _value) {
    _Results = _value;
  }

  void addToResults(dynamic _value) {
    _Results.add(_value);
  }

  void removeFromResults(dynamic _value) {
    _Results.remove(_value);
  }

  void removeAtIndexFromResults(int _index) {
    _Results.removeAt(_index);
  }

  void updateResultsAtIndex(
    int _index,
    dynamic Function(dynamic) updateFn,
  ) {
    _Results[_index] = updateFn(_Results[_index]);
  }

  void insertAtIndexInResults(int _index, dynamic _value) {
    _Results.insert(_index, _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
