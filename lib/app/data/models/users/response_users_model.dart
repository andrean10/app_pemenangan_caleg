import 'package:app_pemenangan_caleg/app/data/models/users/users_model.dart';

class ResponseUsersModel {
  int? status;
  String? message;
  UsersModel? result;

  ResponseUsersModel({this.status, this.message, this.result});

  @override
  String toString() {
    return 'ResponseUsersModel(status: $status, message: $message, result: $result)';
  }

  factory ResponseUsersModel.fromJson(Map<String, dynamic> json) {
    return ResponseUsersModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : UsersModel.fromJson(json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  ResponseUsersModel copyWith({
    int? status,
    String? message,
    UsersModel? result,
  }) {
    return ResponseUsersModel(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
