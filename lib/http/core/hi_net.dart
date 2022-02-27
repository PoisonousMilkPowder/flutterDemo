import 'package:blbl_demo/http/core/dio_adapter.dart';
import 'package:blbl_demo/http/core/hi_error.dart';
import 'package:blbl_demo/http/core/hi_net_adapter.dart';
import 'package:blbl_demo/http/request/base_request.dart';

import 'hi_interceptor.dart';

class HiNet {
  HiNet._();
  HiErrorInterceptor? _hiErrorInterceptor;
  static HiNet? _instance;
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      // print(e.message);
    } catch (e) {
      error = e;
      // print(e);
    }
    if (response == null) {
      print('error=$error');
    }
    var result = response?.data;
    print('result=$result');
    var status = response?.statusCode;
    var hiError;
    switch (status) {
      case 200:
        return result;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        //如果error不为空，则复用现有的error
        hiError =
            error ?? HiNetError(status ?? -1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<dynamic> send<T>(BaseRequest request) {
    return DioAdapter().send(request);
  }

  void setErrorInterceptor(HiErrorInterceptor interceptor) {
    _hiErrorInterceptor = interceptor;
  }
}
