

import 'package:flutter/material.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/state_layout.dart';

class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: "Flutter Practice",
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: "Page Not Found",
      ),
    );
  }
}
