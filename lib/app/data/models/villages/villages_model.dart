class VillagesModel {
  int? id;
  int? districtId;
  String? name;

  VillagesModel({this.id, this.districtId, this.name});

  @override
  String toString() {
    return 'VillagesModel(id: $id, districtId: $districtId, name: $name)';
  }

  factory VillagesModel.fromJson(Map<String, dynamic> data) => VillagesModel(
        id: data['id'] as int?,
        districtId: data['district_id'] as int?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'district_id': districtId,
        'name': name,
      };

  VillagesModel copyWith({
    int? id,
    int? districtId,
    String? name,
  }) {
    return VillagesModel(
      id: id ?? this.id,
      districtId: districtId ?? this.districtId,
      name: name ?? this.name,
    );
  }
}
