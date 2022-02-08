import 'dart:io';


import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(Map<String, dynamic> user);

  Future<UserEntity?> getUser();

  Future<bool> checkUserExists();

  Future<String?> deviceInfo();
  Future<dynamic?> deleteUser();
  Future<dynamic?> saveToken(Map<String,dynamic>params);
  Future<dynamic?> getToken();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {

  @override
  Future<void> saveUser(Map<String, dynamic> user) async {
    final userBox = await Hive.openBox('userBox');
    unawaited(userBox.put('user', user));
  }

  @override
  Future<UserEntity?> getUser() async {
    final userBox = await Hive.openBox('userBox');
    final user = userBox.get('user') as Map<dynamic, dynamic>?;
    if (user != null && user.isNotEmpty) {
      return UserEntity.fromMap(
        Map<String, dynamic>.from(user),
      );
    }
    throw Exception('No User');
  }

  @override
  Future<bool> checkUserExists() async {
    final UserEntity? userModel = await getUser();
    return userModel != null;
  }

  @override
  Future<String?> deviceInfo() async {
    /*final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      Log.d(androidDeviceInfo.device!);
      return androidDeviceInfo.androidId; // unique ID on Android
    }*/
    return "";
  }

  @override
  Future deleteUser() async{
    final userBox = await Hive.openBox('userBox');
    await (userBox.clear());
    return false;
  }

  @override
  Future saveToken(Map<String,dynamic>param)async {
    final tokenBox = await Hive.openBox('tokenBox');
    unawaited(tokenBox.put('token', param));
  }
  @override
  Future getToken()async {

    final tokenBox = await Hive.openBox('tokenBox');
    final token = tokenBox.get('token') as Map<dynamic, dynamic>?;
    print("Token data111112 ${token}");
    if (token != null && token.isNotEmpty) {
      return token['fcm_token'];
    }

    return "";
  }

  /*@override
  Future saveToken(Map<String,dynamic>token)async
  {
    final tokenBox = await Hive.openBox('token');
    unawaited(tokenBox.put('token', token));
  }*/
}
