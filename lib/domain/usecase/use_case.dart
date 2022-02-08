import 'package:dartz/dartz.dart';
import 'package:pet_groom/domain/entities/app_error.dart';



abstract class UseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}

abstract class UseCase2<Type, Params> {
  Future<Type> call(Params params);
}
