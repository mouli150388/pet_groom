import 'package:dartz/dartz.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/domain/repositories/user_repository.dart';

import '../user_local_data_source.dart';


class UserRepositoryImpl extends UserRepository {
  final UserLocalDataSource _dataSource;

  UserRepositoryImpl(this._dataSource);

  @override
  Future<Either<AppError, void>> saveUser(Map<String,dynamic> user) async {
    try {
      final response = await _dataSource.saveUser(user);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, UserEntity?>> getUser() async {
    try {
      final response = await _dataSource.getUser();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, bool>> checkUserExists() async {
    try {
      final response = await _dataSource.checkUserExists();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<String?> deviceInfo() async {
    return _dataSource.deviceInfo();
  }


  @override
  Future<Either<AppError, dynamic>> deleteUser()async {
    try {
      final response = await  _dataSource.deleteUser();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.network,error:"Network Error"));
    }
  }
}
