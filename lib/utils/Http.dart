import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';

typedef void ChildContext(BuildContext context);

class HttpUtil {
  late Dio _dio;
  late BaseOptions options;
  final bool isETD;
  CancelToken cancelToken = CancelToken();

  HttpUtil({this.isETD = false}) {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      // baseUrl: isETD ? Config.etdBaseURL : Config.baseURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 100000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 100000,

      headers: {},
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      // contentType: 'ContentType.json',
      //
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.plain,
    );

    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("accessToken") ?? "";
        var etdToken = prefs.get("etdToken") ?? "";

        var authorization = "Authorization $token";
        if (options.path != "/auth/token") {
          if (token.isNotEmpty && !isETD) {
            options.headers.addAll({"Authorization": authorization});
          }
        }
        options.headers.addAll({"x-auth-token": etdToken});
        print("""
请求之前 😄😄😄😄😄😄😄😄
URL       ${options.baseUrl}${options.path}
HEADERS   ${options.headers}
METHOD    ${options.method}
DATA      ${options.queryParameters}
      """);
        return handler.next(options);
      },
      onResponse:
          (Response response, ResponseInterceptorHandler handler) async {
        var res = jsonDecode(response.data);

        print(""" 
响应之前 🆗🆗🆗🆗🆗🆗🆗🆗
RESPONSE_URL  ${response.realUri.origin}${response.realUri.path}
RESPONSE      ${response.data}
      """);
        return handler.resolve(response);
      },
      onError: (DioError e, ErrorInterceptorHandler handler) async {
        var res = json.decode(e.response!.data);

        print(""" 
错误之前 ❌❌❌❌❌❌❌❌
ERROR_STATUS   ${e.error}
ERROR_RESPONSE ${e.response!.data}
      """);
        return handler.resolve(e.response!);
      },
    ));
  }

  get(
    String url, {
    Map<String, dynamic>? data,
    String? token,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response? response;
    try {
      response = await _dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
      if (url ==
          " http://dns1.turbofil.xyz?_f=get_api&fmt=json&tokenid=20201126024230usqukxqt&app=turbofil_mobile&developer=ks-2021.1.1d") {
        return response.data;
      } else {
        return json.decode(response.data);
      }
    } on HttpUtil catch (e) {
      print(e);
    }
  }

  static Uint8List consolidateHttpClientResponseBytes(dynamic data) {
    final List<List<int>> chunks = <List<int>>[];
    num contentLength = 0;
    chunks.add(data);
    contentLength += data.length;
    final Uint8List bytes = Uint8List(contentLength.toInt());
    int offset = 0;
    for (List<int> chunk in chunks) {
      bytes.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    return bytes;
  }

  post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
    Function(int count, int total)? onSendProgress,
  }) async {
    late Response response;
    FormData? formData;
    try {
      if (data != null) {
        formData = FormData.fromMap(data);
      }
      response = await _dio.post(
        url,
        data: formData,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return json.decode(response.data);
    } on HttpUtil catch (e) {
      print(e);
    }
  }

  /*
   * 下载文件
   */
  downloadFile(
    String urlPath,
    String savePath,
    Function(int count, int total) onReceiveProgress, {
    Options? options,
  }) async {
    Response? response;
    response = await _dio.download(
      urlPath,
      savePath,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      print("请求取消");
    } else {
      print("未知错误");
    }
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
