
import 'package:equatable/equatable.dart';

class ProductModel  extends Equatable{
  int id;
  int price;
  int oldPrice;
  int discount;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,

  }

  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is int ? json['id'] : (json['id'] as double?)?.toInt() ?? 0,
      price: json['price'] is int ? json['price'] : (json['price'] as double?)?.toInt() ?? 0,
      oldPrice: json['old_price'] is int ? json['old_price'] : (json['old_price'] as double?)?.toInt() ?? 0,
      discount: json['discount'] is int ? json['discount'] : (json['discount'] as double?)?.toInt() ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] != null && json['images'] is List
          ? List<String>.from(json['images'])
          : [],
      inFavorites: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }


  // Method to convert a Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'images': images,
      'in_favorites': inFavorites,
      'in_cart': inCart,
    };
  }


  @override
  List<Object?> get props => [id, name, image,images, price,oldPrice, discount, inFavorites,inCart,description];



}




