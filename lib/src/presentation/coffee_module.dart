import 'package:coffee_app/main.dart';
import 'package:coffee_app/src/presentation/controllers/coffee_controller.dart';
import 'package:coffee_app/src/presentation/pages/coffee_page.dart';
import 'package:coffee_app/src/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoffeeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => CoffeeController(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => CoffeeHome(),
    ),
  ];
}
