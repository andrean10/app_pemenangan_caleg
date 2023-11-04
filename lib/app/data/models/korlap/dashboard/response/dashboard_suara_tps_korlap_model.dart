import 'result_dashboard_suara_model.dart';

class DashboardSuaraTpsKorlapModel {
  int? status;
  String? message;
  ResultDashboardSuaraModel? result;

  DashboardSuaraTpsKorlapModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'DashboardSuaraTpsKorlapModel(status: $status, message: $message, result: $result)';
  }

  factory DashboardSuaraTpsKorlapModel.fromJson(Map<String, dynamic> json) {
    return DashboardSuaraTpsKorlapModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultDashboardSuaraModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  DashboardSuaraTpsKorlapModel copyWith({
    int? status,
    String? message,
    ResultDashboardSuaraModel? result,
  }) {
    return DashboardSuaraTpsKorlapModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
