import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/res/styles.dart';
import 'package:practice_project/util/utils.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/my_button.dart';
import 'package:practice_project/widgets/text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  bool _isClick = false;

  @override
  void initState() {
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);

    super.initState();
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _reset() {}

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Please inter you phone number!",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            focusNode: _nodeText1,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2, _nodeText3]),
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "Your phone number",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            controller: _vCodeController,
            keyboardType: TextInputType.number,
            getVCode: () {
              return Future.value(true);
            },
            maxLength: 6,
            hintText: "Please inter your code!",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText3,
            isInputPwd: true,
            controller: _passwordController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Your password",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            onPressed: _isClick ? _reset : null,
            text: "Confirm",
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Reset Password',
      ),
      body: defaultTargetPlatform == TargetPlatform.iOS
          ? FormKeyboardActions(
              autoScroll: _buildBody(),
            )
          : SingleChildScrollView(
              child: _buildBody(),
            ),
    );
  }
}
