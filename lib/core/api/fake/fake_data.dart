

import '../api_constants.dart';
import 'login_user.dart';

Map<String, dynamic> getFakeData(String path) {
  switch (path) {
    case ApiConstants.login:
      return LoginUser();

    default:
      return {};
  }
}
