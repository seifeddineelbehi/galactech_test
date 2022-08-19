class ProductModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? note = "";

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.note,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id:'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
