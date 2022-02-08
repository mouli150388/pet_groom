import 'package:dartz/dartz.dart';
import 'package:pet_groom/data/result.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/entities/request/loginrequest.dart';
import 'package:pet_groom/domain/entities/request/profile_request.dart';
import 'package:pet_groom/domain/entities/request/signup_request.dart';
import 'package:pet_groom/domain/repositories/auth_repository.dart';
import 'package:pet_groom/domain/usecase/use_case.dart';


class LoginUseCase extends UseCase<Result, LoginRequestParams> {
final AuthRepository _repository;

LoginUseCase(this._repository);

@override
Future<Either<AppError, Result>> call(
    LoginRequestParams params) async {
  return _repository.loginUser(params.toJson());
}
}


class SignupUseCase extends UseCase<Result, SignupRequestParams> {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  @override
  Future<Either<AppError, Result>> call(
      SignupRequestParams params) async {
    return _repository.signupUser(params.toJson());
  }
}


class UpdateProfileUC extends UseCase<dynamic, ProfileRequestParams> {
  final AuthRepository _repository;

  UpdateProfileUC(this._repository);

  @override
  Future<Either<AppError, dynamic>> call(ProfileRequestParams params) async {
    return _repository.updateProfile(params.toJson());
  }

}
