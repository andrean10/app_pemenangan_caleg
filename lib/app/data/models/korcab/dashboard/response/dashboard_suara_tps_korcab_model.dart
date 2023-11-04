import 'result_suara_tps_korcab_model.dart';

class DashboardSuaraTpsKorcabModel {
  int? status;
  String? message;
  ResultSuaraTpsKorcabModel? result;

  DashboardSuaraTpsKorcabModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'DashboardSuaraTpsKorcabModel(status: $status, message: $message, result: $result)';
  }

  factory DashboardSuaraTpsKorcabModel.fromJson(Map<String, dynamic> json) {
    return DashboardSuaraTpsKorcabModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultSuaraTpsKorcabModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  DashboardSuaraTpsKorcabModel copyWith({
    int? status,
    String? message,
    ResultSuaraTpsKorcabModel? result,
  }) {
    return DashboardSuaraTpsKorcabModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
