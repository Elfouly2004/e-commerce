
import 'package:equatable/equatable.dart';

class BannersModel extends Equatable {
  final String urlImage;
  final int id;
  final Map<String, dynamic>? category;
  final String? product;

  BannersModel({
    required this.urlImage,
    required this.id,
    this.category,
    this.product,
  });


  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      urlImage: json['image'] ?? '',
      id: json['id'] ?? 0,
      category: json['category'],
      product: json['product'],
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": urlImage,
      "category": category,
      "product": product,
    };
  }

  @override
  // TODO: implement props
  @override
  List<Object?> get props => [urlImage, id, category, product];
}
