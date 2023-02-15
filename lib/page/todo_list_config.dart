import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_ge2/page/theme.dart';
import 'package:projeto_ge2/widgets/appbar.dart';

import '../services/theme_services.dart';

class TodoConfig extends StatefulWidget {
  const TodoConfig({Key? key}) : super(key: key);

  @override
  State<TodoConfig> createState() => _TodoConfigState();
}

class _TodoConfigState extends State<TodoConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarConfig(),
      body: ListView(children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            'Tema',
            style: subHeadingStyle,
          ),
          trailing: Icon(
            Get.isDarkMode ? Icons.nightlight_round : Icons.sunny,
            size: 30,
          ),
          onTap: () {
            setState(() {
              ThemeServices().switchTheme();
            });
          },
        ),
        const Divider(
          thickness: 2,
        )
      ]),
    );
  }
}
