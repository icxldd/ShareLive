import 'dart:html';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:web_test/Common/GlobalChace.dart';
import 'Common/Common.dart';
import 'Common/HttpUrl.dart';
import 'Common/router.dart';
import 'GlobalData/color.dart';
import 'HTTP/request.dart';
import 'Pages/ShowVideo_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

main() async {
  FluroRouter_.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云教会直播',
      // initialRoute: '/Live',
      // routes: <String, WidgetBuilder>{
      //   '/Live': (context) => MyHomePage(title: '云教会'),
      // },
      onGenerateRoute: (x) => FluroRouter_.router.generator(x),
      theme: ThemeData(
        primaryColor: GlobalColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '云教会'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.videoid}) : super(key: key);
  final String title;
  final String videoid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _videoid = '107372194400468992';

  get isHasKey => widget.videoid != '/';
  @override
  Widget build(BuildContext context) {
    ScreenInfo info = getScreenObj(context);
    print(isHasKey);
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: isHasKey
            ? Container(
                child: Column(
                children: [
                  ShowVideo(
                    videoID: widget.videoid,
                  ),
                  // Container(
                  //   child: RaisedButton(
                  //     color: GlobalColor,
                  //     onPressed: () {
                  //       _launchURL(
                  //           "https://church.yangqungongshe.com/promotion/signup/view?guild=$guildId&pastor=$pastorId");
                  //     },
                  //     child: Text('加入教会，观看更多讲道'),
                  //   ),
                  //   width: info.width,
                  //   height: 50,
                  // )
                ],
              ))
            : Container(
                child: Center(
                  child: Text('直播已结束'),
                ),
              ));
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
