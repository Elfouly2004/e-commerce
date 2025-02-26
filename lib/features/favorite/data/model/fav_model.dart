import 'package:equatable/equatable.dart';
import '../../../Home/data/model/product_model.dart';

class FavItemModel extends Equatable {
  final int id;
  final ProductModel product;

  const FavItemModel({
    required this.id,
    required this.product,
  });

  factory FavItemModel.fromJson(Map<String, dynamic> json) {
    print("Parsing FavItemModel: $json");
    return FavItemModel(
      id: json['id'] ?? 0,
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, product];
}
