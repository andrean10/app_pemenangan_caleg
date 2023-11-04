import 'result_jabatan_model.dart';

class JabatanModel {
  int? status;
  String? message;
  List<ResultJabatanModel>? result;

  JabatanModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'JabatanModel(status: $status, message: $message, result: $result)';
  }

  factory JabatanModel.fromJson(Map<String, dynamic> json) => JabatanModel(
        status: json['status'] as int?,
        message: json['message'] as String?,
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => ResultJabatanModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  JabatanModel copyWith({
    int? status,
    String? message,
    List<ResultJabatanModel>? result,
  }) {
    return JabatanModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
