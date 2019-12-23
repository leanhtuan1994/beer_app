import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:practice_project/common/common.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/res/styles.dart';
import 'package:practice_project/routers/fluo_navigator.dart';
import 'package:practice_project/util/utils.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/my_button.dart';
import 'package:practice_project/widgets/text_field.dart';

import '../login_router.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  bool _isClick = false;

  @override
  void initState() {
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
    super.initState();
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        print('isClick change');
        _isClick = isClick;
      });
    }
  }

  void _login() {
    FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
    // NavigatorUtils.push(context, StoreRouter.auditPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: "SMS Login Page",
        onPressed: () {
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
      ),
      body: defaultTargetPlatform == TargetPlatform.iOS
          ? FormKeyboardActions(child: _buildBody())
          : SingleChildScrollView(
              child: _buildBody(),
            ),
    );
  }


  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Login",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "Phone/Your account",
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2]),
            isInputPwd: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: 'Password',
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _isClick ? _login : null,
            text: "Login",
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                'Forget Password',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () {
                //    NavigatorUtils.push(context, LoginRouter.resetPasswordPage)
              },
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  'No account yet? Go to register',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  //NavigatorUtils.push(context, LoginRouter.registerPage)
                },
              )
          )
        ],
      ),
    );
  }
}
