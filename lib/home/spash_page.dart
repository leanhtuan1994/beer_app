import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:practice_project/common/common.dart';
import 'package:practice_project/login/login_router.dart';
import 'package:practice_project/provider/theme_provider.dart';
import 'package:practice_project/routers/fluo_navigator.dart';
import 'package:practice_project/util/image_utils.dart';
import 'package:practice_project/widgets/load_image.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  List<String> _guideList = ["app_start_1", "app_start_2", "app_start_3"];
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SpUtil.getInstance();
      Provider.of<ThemeProvider>(context).syncTheme();

      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: _status == 0
            ? Image.asset(
                ImageUtils.getImgPath("start_page", format: "jpg"),
                width: double.infinity,
                fit: BoxFit.fill,
                height: double.infinity,
              )
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }

  void _initSplash() {
    _streamSubscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, true);
        _initGuide();
        print('initGuide');
      } else {
        print('_goLogin');
        _goLogin();
      }
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }
}
