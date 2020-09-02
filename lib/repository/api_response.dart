import 'api_error.dart';

class APIResponse {
  bool success;
  dynamic result;
  ApiError error;

  APIResponse.success({this.result}) {
    success = true;
  }

  APIResponse.error({this.error}) {
    success = false;
  }
}
