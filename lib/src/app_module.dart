import 'package:coffee_app/src/presentation/coffee_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: CoffeeModule(),
      transition: TransitionType.defaultTransition,
    ),
  ];
}
