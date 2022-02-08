import 'package:dartz/dartz.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/entities/no_params.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/domain/repositories/user_repository.dart';
import 'package:pet_groom/domain/usecase/use_case.dart';





class GetUserUC extends UseCase<UserEntity?, NoParams> {
  final UserRepository _repository;

  GetUserUC(this._repository);

  @override
  Future<Either<AppError, UserEntity?>> call(NoParams params) async {
    return _repository.getUser();
  }
}

class SaveUserUC extends UseCase<void, UserEntity?> {
  final UserRepository _repository;

  SaveUserUC(this._repository);

  @override
  Future<Either<AppError, void>> call(UserEntity? user) async {
    return _repository.saveUser(
      user != null ? user.toJson() : <String, dynamic>{},
    );
  }
}

class DeleteUserUC extends UseCase<dynamic, NoParams> {
  final UserRepository _repository;

  DeleteUserUC(this._repository);

  @override
  Future<Either<AppError, dynamic>> call(NoParams params) {
    return _repository.deleteUser();
  }


}

