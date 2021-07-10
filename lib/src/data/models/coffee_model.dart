import 'dart:convert';

import 'package:coffee_app/src/domain/entities/coffee.dart';

class CoffeeModel extends Coffee {
  final String name;
  final String image;
  final double price;

  CoffeeModel({
    required this.name,
    required this.image,
    required this.price,
  }) : super(
          image: image,
          name: name,
          price: price,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory CoffeeModel.fromMap(Map<String, dynamic> map) {
    return CoffeeModel(
      name: map['name'],
      image: map['image'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoffeeModel.fromJson(String source) =>
      CoffeeModel.fromMap(json.decode(source));

  Coffee toEntity() {
    return Coffee(
      name: name,
      image: image,
      price: price,
    );
  }

  @override
  bool get stringify => true;
}
