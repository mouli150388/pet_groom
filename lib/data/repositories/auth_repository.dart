
import 'package:dartz/dartz.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/repositories/auth_repository.dart';

import '../auth_datasource.dart';
import '../result.dart';


class AuthRepositoryImpl extends AuthRepository{
  AuthDataSource _authDataSource;
  AuthRepositoryImpl(this._authDataSource);
  @override
  Future<Either<AppError, bool>> forgotOtp(Map<String, dynamic> params)async {
    try {
      final response = await  _authDataSource.signupUser(params);
      return Right(true);
    } on Exception {
      return const Left(AppError(AppErrorType.network,error:"Network Error"));
    }
  }

  @override
  Future<Either<AppError, Result>> loginUser(Map<String, dynamic> params)async{
    try {
     /* final response = await  _authDataSource.loginUser(params);
      print("response['code'] ${response.status==9}");
      if(response.status==9)
      return Right(response);*/
       return Left(AppError(AppErrorType.network,error:"Error"));
    } on Exception {
      return const Left(AppError(AppErrorType.network,error:"Network Error"));
    }
  }

  @override
  Future<Either<AppError, Result>> signupUser(Map<String, dynamic> params) async {
   /* try {
      print(params);
      final response = await  _authDataSource.signupUser(params);
      if(response.status==7)
      return Right(response);
      else if(response.status==6)
        return Left(AppError(AppErrorType.network,error:params['dumm_msg']));
      else return Left(AppError(AppErrorType.network,error:response.message));
    } on Exception {
      return const Left(AppError(AppErrorType.network,error:"Network Error"));
    }*/
    return Left(AppError(AppErrorType.network,error:"response.message"));
  }

  @override
  Future<Either<AppError, dynamic>> updateProfile(Map<String, dynamic> params)async {
   /* try {
      final response = await  _authDataSource.updateProfile(params);
      if(response.status==15)
        return Right(response);
      else return Left(AppError(AppErrorType.network,error:response.message));
    } on Exception {*/
      return const Left(AppError(AppErrorType.network,error:"Network Error"));
    //}
  }



}