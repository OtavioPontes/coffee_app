import 'dart:math';

import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  final String name;
  final String image;
  final double price;
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });

  Coffee copyWith({
    String? name,
    String? image,
    double? price,
  }) {
    return Coffee(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  @override
  List<Object> get props => [name, image, price];
}

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;

final Random random = Random();
final _names = [
  "Caramel Macchiato",
  "Caramel Cold Drink",
  "Iced Coffe Mocha",
  "Caramelized Pecan Latte",
  "Toffee Nut Latte",
  "Capuchino",
  "Toffee Nut Iced Latte",
  "Americano",
  "Vietnamese-Style Iced Coffee",
  "Black Tea Latte",
  "Classic Irish Coffee",
  "Toffee Nut Crunch Latte",
];
final List<Coffee> coffees = List.generate(
  _names.length,
  (index) => Coffee(
    name: _names[index],
    image: 'assets/images/coffees/${index + 1}.png',
    price: _doubleInRange(random, 3, 7),
  ),
).toList();
