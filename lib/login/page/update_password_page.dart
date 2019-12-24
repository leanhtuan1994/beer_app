import 'package:flutter/material.dart';
import 'package:practice_project/res/dimens.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/res/styles.dart';
import 'package:practice_project/routers/fluo_navigator.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/my_button.dart';
import 'package:practice_project/widgets/text_field.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  TextEditingController _oldPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  bool _isClick = false;

  @override
  void initState() {
    _oldPwdController.addListener(_verify);
    _newPwdController.addListener(_verify);
    super.initState();
  }

  void _verify() {
    String oldPwd = _oldPwdController.text;
    String newPwd = _newPwdController.text;
    bool isClick = true;
    if (oldPwd.isEmpty || oldPwd.length < 6) {
      isClick = false;
    }
    if (newPwd.isEmpty || newPwd.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _confirm() {
    NavigatorUtils.goBack(context);
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Reset Your Password",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap8,
          Text(
            "Setting 15000000000",
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: Dimens.font_sp12),
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          MyTextField(
            isInputPwd: true,
            controller: _oldPwdController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Please inter your old password",
          ),
          Gaps.vGap8,
          MyTextField(
            isInputPwd: true,
            controller: _newPwdController,
            maxLength: 16,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Please inter your new password",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            onPressed: _isClick ? _confirm : null,
            text: "Update",
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Update Password',
      ),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }
}
