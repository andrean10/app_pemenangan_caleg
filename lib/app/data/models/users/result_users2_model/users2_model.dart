import 'result_users2_model.dart';

class Users2Model {
  int? status;
  String? message;
  ResultUsers2Model? result;

  Users2Model({this.status, this.message, this.result});

  @override
  String toString() {
    return 'Users2Model(status: $status, message: $message, result: $result)';
  }

  factory Users2Model.fromJson(Map<String, dynamic> json) {
    return Users2Model(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultUsers2Model.fromJson(json['result'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result?.toJson(),
      };

  Users2Model copyWith({
    int? status,
    String? message,
    ResultUsers2Model? result,
  }) {
    return Users2Model(
      status: status ?? this.status,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }
}
