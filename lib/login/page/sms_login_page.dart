import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:practice_project/login/login_router.dart';
import 'package:practice_project/res/dimens.dart';
import 'package:practice_project/res/gaps.dart';
import 'package:practice_project/res/styles.dart';
import 'package:practice_project/routers/fluo_navigator.dart';
import 'package:practice_project/util/toast.dart';
import 'package:practice_project/util/utils.dart';
import 'package:practice_project/widgets/app_bar.dart';
import 'package:practice_project/widgets/my_button.dart';
import 'package:practice_project/widgets/text_field.dart';

class SMSLoginPage extends StatefulWidget {
  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;

  void _verify() {
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: defaultTargetPlatform == TargetPlatform.iOS
          ? FormKeyboardActions(
              child: _buildBody(),
            )
          : SingleChildScrollView(
              child: _buildBody(),
            ),
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Login Code',
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            focusNode: _nodeText1,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2]),
            controller: _phoneController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: 'Your phone number',
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            controller: _vCodeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: 'Press your code',
            getVCode: () {
              return Future.value(true);
            },
          ),
          Gaps.vGap8,
          Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              child: RichText(
                text: TextSpan(
                    text: '',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontSize: Dimens.font_sp14),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Your phone no register yet',
                          style:
                              TextStyle(color: Theme.of(context).errorColor)),
                      TextSpan(text: '。'),
                    ]),
              ),
              onTap: () {
                NavigatorUtils.push(context, LoginRouter.registerPage);
              },
            ),
          ),
          Gaps.vGap15,
          Gaps.vGap10,
          MyButton(
            onPressed: _isClick ? _login : null,
            text: 'Login',
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                'Forget Password',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
            ),
          )
        ],
      ),
    );
  }

  void _login() {
    Toast.show('_login');
  }
}
