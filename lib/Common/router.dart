import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:web_test/Pages/ShowVideo_page.dart';

import '../main.dart';

// ignore: camel_case_types
class FluroRouter_ {
  static final router = FluroRouter();
  //Define  your routers here
  static void setupRouter() {
    router.define('/:liveId', handler: _liveHandler);
  }

  //Add your handlers here
  static Handler _liveHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => MyHomePage(
            videoid: params['liveId'].first,
            title: '讲道直播',
          ));
}
