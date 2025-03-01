import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final int id;
  final String urlImage;

  final String name;

  const CategoriesModel({
    required this.urlImage,
    required this.id,
    required this.name,

  }
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image":urlImage,
      "name":name,
    };
  }
  @override
  List<Object?> get props => [id, urlImage, name];

}
