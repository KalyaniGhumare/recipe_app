class IngredientDetails {
  int? id;
  String? name, quantity;

  IngredientDetails({
    this.id,
    this.name,
    this.quantity,
  });

  factory IngredientDetails.fromJson(Map<String, dynamic> json) {
    return IngredientDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}
