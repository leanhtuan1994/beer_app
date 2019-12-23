


import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:practice_project/home/home_page.dart';
import 'package:practice_project/home/webview_page.dart';
import 'package:practice_project/login/login_router.dart';

import '404.dart';
import 'router_init.dart';

class Routes {

  static String home = "/home";
  static String webViewPage = "/webview";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    ///
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint("configureRoutes");
        return WidgetNotFound();
      });

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));
    
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params){
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));
    
    _listRouter.clear();
    ///
    // _listRouter.add(ShopRouter());
     _listRouter.add(LoginRouter());
    // _listRouter.add(GoodsRouter());
    // _listRouter.add(OrderRouter());
    // _listRouter.add(StoreRouter());
    // _listRouter.add(AccountRouter());
    // _listRouter.add(SettingRouter());
    // _listRouter.add(StatisticsRouter());
  
    ///
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}
