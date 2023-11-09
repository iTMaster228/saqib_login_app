// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FieldStruct extends BaseStruct {
  FieldStruct({
    List<double>? fruit,
  }) : _fruit = fruit;

  // "FRUIT" field.
  List<double>? _fruit;
  List<double> get fruit => _fruit ?? const [];
  set fruit(List<double>? val) => _fruit = val;
  void updateFruit(Function(List<double>) updateFn) => updateFn(_fruit ??= []);
  bool hasFruit() => _fruit != null;

  static FieldStruct fromMap(Map<String, dynamic> data) => FieldStruct(
        fruit: getDataList(data['FRUIT']),
      );

  static FieldStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? FieldStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'FRUIT': _fruit,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'FRUIT': serializeParam(
          _fruit,
          ParamType.double,
          true,
        ),
      }.withoutNulls;

  static FieldStruct fromSerializableMap(Map<String, dynamic> data) =>
      FieldStruct(
        fruit: deserializeParam<double>(
          data['FRUIT'],
          ParamType.double,
          true,
        ),
      );

  @override
  String toString() => 'FieldStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FieldStruct && listEquality.equals(fruit, other.fruit);
  }

  @override
  int get hashCode => const ListEquality().hash([fruit]);
}

FieldStruct createFieldStruct() => FieldStruct();
