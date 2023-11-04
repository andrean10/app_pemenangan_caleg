class VillagesHeaderModel {
  int? id;
  int? districtId;
  String? name;

  VillagesHeaderModel({this.id, this.districtId, this.name});

  @override
  String toString() {
    return 'VillagesHeaderModel(id: $id, districtId: $districtId, name: $name)';
  }

  factory VillagesHeaderModel.fromJson(Map<String, dynamic> json) =>
      VillagesHeaderModel(
        id: json['id'] as int?,
        districtId: json['district_id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'district_id': districtId,
        'name': name,
      };

  VillagesHeaderModel copyWith({
    int? id,
    int? districtId,
    String? name,
  }) {
    return VillagesHeaderModel(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      name: name ?? this.name,
    );
  }
}
