



import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/repositories/user_local_data_source.dart';
import 'package:pet_groom/data/result.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/no_params.dart';
import 'package:pet_groom/domain/entities/response_entity.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/domain/usecase/user_usecase.dart';

abstract class AuthDataSource{
  Future<ApiResponse> loginUser(Map<String, dynamic> requestBody);
  Future<ApiResponse> signupUser(Map<String, dynamic> requestBody);
  Future<ApiResponse> updateProfile(Map<String, dynamic> requestBody);
  Future<dynamic> getUserDetails(Map<String, dynamic> requestBody);
  Future<Result> sendPassword(Map<String, dynamic> requestBody);
  Future<dynamic> logutUser();
}

class AuthDataSourceIMpl extends AuthDataSource{
  ApiClient _apiClient;
  //SaveUserUC saveUserUC;

  AuthDataSourceIMpl(this._apiClient);
  @override
  Future<ApiResponse> loginUser(Map<String, dynamic> requestBody) async{
    print("Response Request ");

    var response= await _apiClient.post(ApiConstants.login, body:requestBody,fakeData: false,token: "") ;
    ApiResponse resp=ApiResponse.fromMap(response);
    /*if(resp.code=="9")
    {
      UserLocalDataSource _userLocalDataSource=getItInstance();
      _userLocalDataSource.saveUser((response['data']));
      ApiConstants.USER_ID=response['data']['id'];
      ApiConstants.IMAGE=response['data']['profile_picture'];
      ApiConstants.user_country_code=response['data']['user_country_code'];
      ApiConstants.USER_Name=response['data']['name'];
      NoParams params=NoParams();
     // print("Response Print User ${await getUserUC.call(params)}");
      result=Result(int.parse(response['code']),"Success");
    }else
      {
        result=Result(int.parse(response['code']),response['data']);
      }*/
    print("Response Request ${response['code']=9}");

    return resp;
  }



  @override
  Future<ApiResponse> signupUser(Map<String, dynamic> requestBody) async{
    var response= await _apiClient.post(ApiConstants.signup, body:requestBody,fakeData: false,token: "") ;
    ApiResponse resp=ApiResponse.fromMap(response);
    if(resp.code=="7")
    {

     /* ApiConstants.USER_ID=response['data']['id'].toString();
      ApiConstants.IMAGE=(response['data'].containsKey('profile_picture'))?((response['data']['profile_picture']==null)?"":response['data']['profile_picture']):"";
      ApiConstants.user_country_code=response['data']['user_country_code'];
      ApiConstants.USER_Name=response['data']['name'];
      NoParams params=NoParams();*/


    }

    print("Response ${response['code']=7}");
   // Result result=Result(response['code'],response['data']);
    return resp;
  }

  @override
  Future logutUser() {
    // TODO: implement lgoutUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> updateProfile(Map<String, dynamic> requestBody) async{

    var response= await _apiClient.post(ApiConstants.updateProfile, body:requestBody,fakeData: false,token: "") ;
    ApiResponse resp=ApiResponse.fromMap(response);
    if(response['code']=="15")
    {
     // saveUserUC.call(UserEntity.fromMap(response['data']));
      ApiConstants.USER_ID=response['data']['id'];
      ApiConstants.IMAGE=response['data']['profile_picture'];
      ApiConstants.USER_Name=response['data']['name'];

      NoParams params=NoParams();
     // print("Response Print User ${await getUserUC.call(params)}");

    }else
    {

    }
    return resp;
  }





  @override
  Future<dynamic> getUserDetails(Map<String, dynamic> requestBody) async{

    var response= await _apiClient.post(ApiConstants.getUserDetails, body:requestBody,fakeData: false,token: "") ;
   if(response==null)
     return Future.value(null);
    ApiResponse resp=ApiResponse.fromMap(response);
    print("result ${response}");
    if(response['code']=="5")
    {

     // saveUserUC.call(userEntity);
      ApiConstants.USER_ID=response['data']['id'];
      ApiConstants.IMAGE=response['data']['profile_picture'];
      ApiConstants.USER_Name=response['data']['name'];

    }

    return resp;

  }

  @override
  Future<Result> sendPassword(Map<String, dynamic> requestBody) async{

    var response= await _apiClient.post(ApiConstants.forgotpassword, body:requestBody,fakeData: false,token: "") ;

    print("result ${response}");
   return Result(int.parse(response['code']),response['data']);


  }
/*  @override
  Future<Result>sendToken(Map<String, dynamic> requestBody)async{

    return Result(1,"");
  }*/
}