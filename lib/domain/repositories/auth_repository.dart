import 'package:dartz/dartz.dart';
import 'package:pet_groom/data/result.dart';
import 'package:pet_groom/domain/entities/app_error.dart';

abstract class AuthRepository {
  Future<Either<AppError, Result>> loginUser(Map<String, dynamic> params);
  Future<Either<AppError, Result>> signupUser(Map<String, dynamic> params);
  Future<Either<AppError, dynamic>> updateProfile(Map<String, dynamic> params);
  Future<Either<AppError, bool>> forgotOtp(Map<String, dynamic> params);
}