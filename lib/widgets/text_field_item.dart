import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/util/number_text_input_formatter.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({Key key, this.controller, @required this.title, this.keyboardType: TextInputType.text, this.hintText: "", this.focusNode, this.config})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;

  @override
  Widget build(BuildContext context) {
    if (config != null && defaultTargetPlatform == TargetPlatform.iOS) {
      FormKeyboardActions.setKeyboardActions(context, config);
    }
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: TextField(
                focusNode: focusNode,
                keyboardType: keyboardType,
                inputFormatters: _getInputFormatters(),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                )),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters() {
    if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return [UsNumberTextInputFormatter()];
    }
    if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone) {
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
