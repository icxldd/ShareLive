import 'package:dio/dio.dart';

Dio dio = Dio(); // 使用默认配置
String token = "";
void initDio() {
  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    String token = await initToken();
    options.headers["X-ss-pid"] = token;
    options.headers["X-ss-opt"] = "perm";
    print('initdto');
    return options;
  }, onResponse: (Response response) async {
    return response;
  }, onError: (DioError e) async {
    return e;
  }));
}

// ignore: missing_return
Future<String> initToken() async {
  try {
    Response response = await Dio().post(
        "https://church.yangqungongshe.com/account/auth/mobile",
        data: {"PhoneNumber": '13588888888', 'Token': '8888'});
    return response.data["sessionId"];
  } catch (e) {
    print(e);
  }
}

Future<dynamic> getLiveInfo(livecastid) async {
  if (token == "") {
    token = await initToken();
  } else {}
  Options op = new Options();
  op.headers["X-ss-pid"] = token;
  op.headers["X-ss-opt"] = "perm";
  Response response = await Dio().get(
      "https://church.yangqungongshe.com/module/livecast/show?LivecastId=" +
          livecastid,
      options: op);
  // print(response.data);
  return response.data;
}
