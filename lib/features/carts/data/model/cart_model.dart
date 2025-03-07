import 'package:equatable/equatable.dart';
import '../../../Home/data/model/product_model.dart';

class CartItemModel extends Equatable {
  final int id;
  final int quantity;
  final ProductModel product;

  const CartItemModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 1,
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      quantity: quantity ?? this.quantity,
      product: product,
    );
  }

  @override
  List<Object?> get props => [id, quantity, product];
}
