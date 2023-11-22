class UserSession {
  final int id;
  final String token;
  final String role;
  final int provincesId;
  final int regenciesId;
  final int districtsId;

  UserSession({
    required this.id,
    required this.token,
    required this.role,
    required this.provincesId,
    required this.regenciesId,
    required this.districtsId,
  });

  @override
  String toString() {
    return 'UserSession(id: $id, token: $token, role: $role, provincesId: $provincesId, regenciesId: $regenciesId, districtsId: $districtsId)';
  }
}
