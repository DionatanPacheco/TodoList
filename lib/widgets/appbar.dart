import 'package:flutter/material.dart';
import 'package:projeto_ge2/page/theme.dart';

appBarForm() {
  return AppBar(
    title: Text('Agendamento', style: subHeadingStyle),
    backgroundColor: const Color.fromARGB(255, 252, 120, 120),
  );
}

appBarConfig() {
  return AppBar(
      backgroundColor: const Color.fromARGB(255, 252, 120, 120),
      title: Text(
        'Configuração',
        style: subHeadingStyle,
      ));
}
