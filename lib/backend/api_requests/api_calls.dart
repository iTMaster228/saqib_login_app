import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class DataURLCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'DataURL',
      apiUrl:
          'https://script.google.com/macros/s/AKfycbxgg1K0uek01LFz5p8jaKM78GBfBPJsp6EAIxe-5XY7yXrzN4w4JigJLxBFoKiG1E52_A/exec',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic productList(dynamic response) => getJsonField(
        response,
        r'''$.products''',
        true,
      );
}

class SearchableCall {
  static Future<ApiCallResponse> call({
    String? searchvalue = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Searchable',
      apiUrl:
          'https://script.google.com/macros/s/AKfycbzN8CykJ9qxLv44yLYiho2tkTPS1Q1f-41GAvO7tRws86A6gbeOWpPQQACra4qNvD9H9A/exec?filterColumn=Vendors&filterValue=${searchvalue}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic product(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
