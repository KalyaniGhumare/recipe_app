class StepDetails {
  int? id;
  String? name, imageUrl;

  StepDetails({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory StepDetails.fromJson(Map<String, dynamic> json) {
    return StepDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = imageUrl;
    return data;
  }
}
