import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:pet_groom/core/api/fake/fake_data.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/providers/connectivity.dart';

import 'exception_handling.dart';

class ApiClient {
  final Dio _dio;
  final Connectivity _connectivity;

  const ApiClient(this._dio, this._connectivity);

  dynamic get(
    String path,bool isDummy, {
    String? token,
    Map<String, dynamic>? query,

  }) async {
    if(isDummy)
      {
       return getFakeData(path);

      }
    if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
       NetworkException("Network Error");
      return;
    }
    dynamic response;
    try {
      print('[API-REQ]-> $path: $query');
      response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(
          method: 'GET',
          headers: token != null ? {'Authorization': token} : null,
        ),
      );
    } catch (e) {
      print('try-catch: $e');
      throw Exception(e);
    }

    if (response?.statusCode == 200) {
      return response.data;
    } else if (response?.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  dynamic post(
    String path, {
    String token = '',
    required Map<String, dynamic> body,
    bool fakeData = false,
  }) async {
    print("Request Request: ${body}");
    dynamic response;
    try {
      if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
        ConnectivityCubit(getItInstance()).emit(false);
        return;
      }
      var f=FormData.fromMap(body);


      try {
        response = await _dio.post(
          path,
          data: FormData.fromMap(body),
          options: Options(
            method: 'POST',
            headers: {'Authorization': token},
          ),
        );
      } catch (e) {
        print(e.toString());
        return null;
      }
    } on PlatformException catch (_) {
      throw NetworkException("");
    }

    print("response123 ${path}");
    print("response123 ${response}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else if (response.statusCode == 203) {
      print('Api-client: InvalidAccessTokenException');
      throw InvalidAccessTokenException(response.data!['message'] as String);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.statusMessage);
    }
  }


  Future uploadImage({dynamic data,required Options options,required String path,required bool isImage}) async{
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          // Do something before request is sent
          print("Image Upload Resposne 1 ${options.data}" );
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onResponse:(response,handler) {
          // Do something with response data
          print("Image Upload Resposne 1 ${response.data}" );
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          print("Image Upload Resposne 1 ${e.response}" );
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));
    print("Image picker uploading21212 ${data}" );
    Response apiRespon =  await _dio.post(path,data: data,options: options);

    print("Image picker uploading21212 ${apiRespon.data}" );
    if(isImage)
      {
        return apiRespon.data;
      }else
        {
          if(apiRespon.statusCode== 201||apiRespon.statusCode== 200){
            return (apiRespon.data['code']==23||apiRespon.data['code']=="23");

          }else{
            print('errr');
            return false;
          }
        }

  }

}
