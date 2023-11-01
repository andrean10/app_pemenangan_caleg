import 'dart:convert';

import 'package:collection/collection.dart';

import 'data_login.dart';

class ResultLoginModel {
  DataLogin? data;
  String? token;

  ResultLoginModel({this.data, this.token});

  @override
  String toString() => 'ResultLoginModel(data: $data, token: $token)';

  factory ResultLoginModel.fromMap(Map<String, dynamic> data) =>
      ResultLoginModel(
        data: data['data'] == null
            ? null
            : DataLogin.fromMap(data['data'] as Map<String, dynamic>),
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resultLoginModeling Json object as [ResultLoginModel].
  factory ResultLoginModel.fromJson(String data) {
    return ResultLoginModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ResultLoginModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ResultLoginModel copyWith({
    DataLogin? data,
    String? token,
  }) {
    return ResultLoginModel(
      data: data ?? this.data,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ResultLoginModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => data.hashCode ^ token.hashCode;
}
