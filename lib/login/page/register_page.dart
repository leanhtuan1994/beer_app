import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/res/styles.dart';
import 'package:practice_project/util/toast.dart';
import 'package:practice_project/util/utils.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/my_button.dart';
import 'package:practice_project/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;

  @override
  void initState() {
    _nameController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passController.addListener(_verify);
    super.initState();
  }

  void _verify() {
    String name = _nameController.text;
    String vCode = _vCodeController.text;
    String password = _passController.text;
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

  void _register() {}

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Create your account',
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2, _nodeText3]),
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "Please inter your phone number",
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('vcode'),
            focusNode: _nodeText2,
            controller: _vCodeController,
            keyboardType: TextInputType.number,
            getVCode: () async {
              if (_nameController.text.length == 11) {
                Toast.show("");
                return true;
              } else {
                Toast.show("Your code not correct!");
                return false;
              }
            },
            maxLength: 6,
            hintText: "Please inter your code",
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText3,
            isInputPwd: true,
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: "Password",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('register'),
            onPressed: _isClick ? _register : null,
            text: "Register",
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Register Page'),
      body: defaultTargetPlatform == TargetPlatform.iOS
          ? FormKeyboardActions(
              child: _buildBody(),
            )
          : SingleChildScrollView(
              child: _buildBody(),
            ),
    );
  }
}
