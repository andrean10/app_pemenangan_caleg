class RoleModel {
  int? id;
  String? namaRoles;

  RoleModel({this.id, this.namaRoles});

  @override
  String toString() => 'RoleModel(id: $id, namaRoles: $namaRoles)';

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json['id'] as int?,
        namaRoles: json['nama_roles'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_roles': namaRoles,
      };

  RoleModel copyWith({
    int? id,
    String? namaRoles,
  }) {
    return RoleModel(
      id: id ?? this.id,
      namaRoles: namaRoles ?? this.namaRoles,
    );
  }
}
