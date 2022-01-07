import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tripleintoxianimeapi/modules/home/presenter/view/home.page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IntoxiAnimes API - Triple',
      home: HomePage(),
    ).modular();
  }
}
