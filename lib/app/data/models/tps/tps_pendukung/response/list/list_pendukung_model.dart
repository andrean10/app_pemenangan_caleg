import 'result_list_pendukung_model.dart';

class ListPendukungModel {
  int? status;
  String? message;
  ResultListPendukungModel? result;

  ListPendukungModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'ListPendukungModel(status: $status, message: $message, result: $result)';
  }

  factory ListPendukungModel.fromJson(Map<String, dynamic> json) {
    return ListPendukungModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultListPendukungModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  ListPendukungModel copyWith({
    int? status,
    String? message,
    ResultListPendukungModel? result,
  }) {
    return ListPendukungModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
