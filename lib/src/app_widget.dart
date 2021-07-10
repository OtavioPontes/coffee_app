import 'package:coffee_app/src/utils/screen/design_ui.dart';
import 'package:coffee_app/src/utils/screen/screen_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtil.builder(
      designUI: DesignUI.iPhone11ProMax,
      designUITablet: DesignUI.iPadPro10dot5,
      builder: (context, constraints, orientation) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Coffee App',
          theme: ThemeData.light(),
          themeMode: ThemeMode.light,
        ).modular();
      },
    );
  }
}
