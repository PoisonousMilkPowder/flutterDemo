import 'package:blbl_demo/http/core/hi_net_adapter.dart';
import 'package:blbl_demo/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {'code': 0, 'message': 'success'} as T, statusCode: 200);
    });
  }
}
