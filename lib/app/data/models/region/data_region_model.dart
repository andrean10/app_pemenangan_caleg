import 'package:equatable/equatable.dart';

class DataRegionModel extends Equatable {
  final int? id;
  final String? value;

  const DataRegionModel({this.id, this.value});

  factory DataRegionModel.fromJson(Map<String, dynamic> map) {
    return DataRegionModel(
      id: map['id'] as int,
      value: map['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': value,
    };
  }

  @override
  String toString() {
    return 'DataRegionModel{id: $id, value: $value}';
  }

  @override
  List<Object?> get props => [id, value];
}
