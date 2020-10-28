import 'dart:convert';
import 'dart:html';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:web_test/Common/Common.dart';
import 'package:web_test/Common/GlobalChace.dart';
import 'package:web_test/HTTP/request.dart';

class ShowVideo extends StatefulWidget {
  // ignore: non_constant_identifier_names

  @override
  _ShowVideoState createState() => _ShowVideoState();

  final String videoID;
  // ignore: non_constant_identifier_names
  ShowVideo({Key key, @required this.videoID});
}

class _ShowVideoState extends State<ShowVideo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenInfo info = getScreenObj(context);

    // print(widget.videoID);
    return FutureBuilder<dynamic>(
        future: getLiveInfo(widget.videoID),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            String title = snapshot.data["livecast"]["title"],
                createdDate = snapshot.data["livecast"]["createdDate"],
                creatordisplayName =
                    snapshot.data["livecast"]["creator"]["displayName"],
                guilddisplayName =
                    snapshot.data["livecast"]["guild"]["displayName"],
                description = snapshot.data["livecast"]["description"];
            dynamic files = snapshot.data["livecast"]["imageFiles"];

            guildId = snapshot.data["livecast"]["guild"]["guildId"];
            pastorId = snapshot.data["livecast"]["creator"]["userId"];
            return Container(
              height: info.height - 120,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     width: 1, //                   <--- border width here
              //   ),
              // ),
              child: Column(
                children: [
                  buildIjkPlayer(snapshot.data["livecast"]["hlsPlayUrl"]),
                  Container(
                    // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 15, left: 15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(
                            child: Row(
                              children: [
                                Text(guilddisplayName,
                                    style: TextStyle(
                                        // color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                Text('  '),
                                Text("牧师 : " + creatordisplayName),
                                Text(' | '),
                                Text(createdDate)
                              ],
                            ),
                            margin: EdgeInsets.only(top: 15, bottom: 15)),
                        Container(
                          child: Text(
                            '简介:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          margin: EdgeInsets.only(bottom: 15),
                        ),
                        (description ?? '') == ''
                            ? Container(
                                child:
                                    Text(creatordisplayName + '  牧师此次直播没有发布简介'),
                                margin: EdgeInsets.only(bottom: 15),
                              )
                            : Container(
                                child: Text(description),
                                margin: EdgeInsets.only(bottom: 15),
                              ),
                        // Container(
                        //   child: Text(
                        //     '图片资料:',
                        //     style: TextStyle(
                        //         fontSize: 18, fontWeight: FontWeight.bold),
                        //   ),
                        //   margin: EdgeInsets.only(bottom: 10),
                        // ),
                        // buildImages(creatordisplayName, files)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget buildImages(creatordisplayName, dynamic files) {
    return files.length == 0
        ? Container(
            child: Text(creatordisplayName + '  牧师此次直播没有发布资料'),
            margin: EdgeInsets.only(bottom: 10),
          )
        : Wrap(
            spacing: 15.0, // 主轴(水平)方向间距
            runSpacing: 10.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: List.generate(files.length, (index) {
              return Image.network(
                files[index]["url"],
                width: 80.0,
              );
            }),
          );
  }

  Widget buildIjkPlayer(url) {
    return EasyWebView(
      src: "http://150.158.131.209:8888/LiveShare/index.html?LiveAdress=" + url,
      isHtml: false,
      isMarkdown: false, onLoaded: () {},
      // width: 100,
      height: 250,
    );
  }
}
