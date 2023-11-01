class UserSession {
  final int id;
  final String token;
  final String role;

  UserSession({
    required this.id,
    required this.token,
    required this.role,
  });

  @override
  String toString() {
    return 'UserSession(id: $id, token: $token, role: $role)';
  }
}
