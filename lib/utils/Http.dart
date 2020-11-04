import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:bot_toast/bot_toast.dart';

typedef void ChildContext(BuildContext context);

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;
  String baseUrl;
  Map<String, dynamic> commonParameter = {
    'system_type': Platform.operatingSystem,
    // 'time_stamp': Utils.currentTimeMillis(),
    // 'version_num': Config.VERSION,
  };

  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = HttpUtil();
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
        "version": "1.0.2"
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      contentType: 'ContentType.json',
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    dio = Dio(options);

    //Cookie管理
    // dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求之前 $options");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) async {
      // print("响应之前");
      // Map data = json.decode(response.data);
      // if (data['code'] == 20001) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('token', '123');
      // prefs.remove('token');
      // UserInfo().logout();
      // Navigator.of(context).pushNamed('login');
      // } else if (data['code'] == 20003) {
      //   return response;
      // } else if (data['code'] != 0) {
      //   BotToast.closeAllLoading();
      //   BotToast.showText(text: data['msg']);
      // }
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    }));
  }

  /*
   * get请求
   */
  get(url, {Map<String, dynamic> data, token, options, cancelToken}) async {
    Response response;

    // if (data != null) {
    //   data.addAll(commonParameter);
    // } else {
    //   data = commonParameter;
    // }
    // if (Config.setToken) {
    //   data['token'] = Config.token;
    // } else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   data['token'] = prefs.getString('token') ?? '';
    // }

    // data.addAll({'sign': Utils.generateSign(data)});
    // print(data);
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return json.decode(response.data);
  }

  /*
   * post请求
   */
  post(url,
      {Map<String, dynamic> data,
      token,
      queryParams,
      options,
      cancelToken}) async {
    Response response;
    // if (data != null) {
    //   data.addAll(commonParameter);
    // } else {
    //   data = commonParameter;
    // }
    // if (Config.setToken) {
    //   data['token'] = Config.token;
    // } else {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   data['token'] = prefs.getString('token');
    // }
    // data.addAll({'sign': Utils.generateSign(data)});
    FormData fromData = FormData.fromMap(data);
    print(data);
    try {
      response = await dio.post(url,
          data: fromData,
          queryParameters: queryParams,
          options: options,
          cancelToken: cancelToken);
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
    }
    return json.decode(response.data);
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      showOverTimer();
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      showOverTimer();
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      showOverTimer();
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  void showOverTimer() {
    BotToast.removeAll();
    UniqueKey key = UniqueKey();
    BotToast.showWidget(
        key: key,
        toastBuilder: (context) {
          return Scaffold(
              //child里面的内容不会因为数据的改变而重绘
              appBar: AppBar(
                title: Text(
                  '网络连接失败',
                  style: TextStyle(color: Colors.black),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    BotToast.remove(key);
                  },
                ),
                // backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
              ),
              body: Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/images/overtime.png',
                      width: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '网络连接失败',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '请检查您的网络设置',
                      style: TextStyle(
                          color: Color.fromRGBO(153, 153, 153, 1),
                          fontSize: 14),
                    ),
                  ],
                ),
              ));
        });
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
