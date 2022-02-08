import 'package:dartz/dartz.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';


abstract class UserRepository {
  Future<Either<AppError, void>> saveUser(Map<String, dynamic> user);

  Future<Either<AppError, UserEntity?>> getUser();

  Future<Either<AppError, bool>> checkUserExists();
  Future<Either<AppError, dynamic>> deleteUser();

  Future<String?> deviceInfo();
}
