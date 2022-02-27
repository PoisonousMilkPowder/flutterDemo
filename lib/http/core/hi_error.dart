class HiNetError implements Exception {
  HiNetError(this.code, this.message, {this.data});
  final int code;
  final String message;
  final dynamic data;
}

class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}

class NeedLogin extends HiNetError {
  NeedLogin({int code = 401, String message = '请先登录'}) : super(code, message);
}
