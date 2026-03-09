//基于Dio的二次封装工具类
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

class DioRequest {
  final _dio = Dio();

  //基础地址拦截器
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.baseUrl
      ..connectTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIMEOUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIMEOUT);
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (tokenManager.getToken().isNotEmpty) {
            options.headers = {
              "Authorization": "Bearer ${tokenManager.getToken()}",
            };
          }

          // 在发送请求之前做一些事情
          return handler.next(options); // 继续发送请求
        },
        onResponse: (response, handler) {
          // 在响应数据之前做一些事情
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response); // 继续处理响应
          }

          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        onError: (err, handler) {
          // 当请求失败时做一些事情
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              message: err.response?.data["msg"] ?? "  ",
            ),
          ); // 继续处理错误
        },
      ),
    );
  }

  // 定义get接口
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  //定义post接口
  Future<dynamic> post(String url, {Map<String, dynamic>? params}) async {
    return _handleResponse(_dio.post(url, data: params));
  }

  //进一步处理返回结果
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    Response<dynamic> res = await task;
    final data = res.data as Map<String, dynamic>;
    try {
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        //判断业务状态码是否为1
        return data["result"];
      } else {
        throw DioException(
          requestOptions: res.requestOptions,
          message: data["msg"] ?? "加载数据失败",
        );
      }
    } catch (e) {
      rethrow; //不改变原来抛出的异常
    }
  }
}

final DioRequest dioRequest = DioRequest();

//dio请求工具发出请求，返回的数据 Response<dynamic>.data
//把所有的接口的data统一处理，拿到真正数据，判断业务状态码是否为1
