import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_test/Common/GlobalChace.dart';
import 'Common/Common.dart';
import 'Common/HttpUrl.dart';
import 'GlobalData/color.dart';
import 'HTTP/request.dart';
import 'Pages/ShowVideo_page.dart';
import 'package:url_launcher/url_launcher.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '云教会直播',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => MyHomePage(title: '云教会'),
      },
      theme: ThemeData(
        primaryColor: GlobalColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '云教会'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _videoid = '';

  @override
  Widget build(BuildContext context) {
    ScreenInfo info = getScreenObj(context);
    // var val = getQueryParameters();
    // if (val == null) {
    //   _videoid = getCookie('liveId');
    // } else {
    //   _videoid = val['liveId'] ?? "107363190861365248";
    //   setCookie('liveId', _videoid);
    //   // print(getCookie('liveId'));
    // }
    //107372194400468992
    //106738710711533568
    var val = getQueryParameters();
    if ((val['liveId'] ?? '') != '') {
      liveId = val['liveId'];
      _videoid = val['liveId'];
    } else {
      _videoid = liveId;
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: Container(
            child: Scrollbar(
          child: Column(
            children: [
              ShowVideo(
                videoID: _videoid,
              ),
              Container(
                child: RaisedButton(
                  color: GlobalColor,
                  onPressed: () {
                    _launchURL(
                        "https://church.yangqungongshe.com/promotion/signup/view?guild=$guildId&pastor=$pastorId");
                  },
                  child: Text('加入教会，观看更多讲道'),
                ),
                width: info.width,
                height: 50,
              )
            ],
          ),
        )));
  }
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
