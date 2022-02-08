
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_groom/blocs/auth/auth_cubit.dart';
import 'package:pet_groom/blocs/auth/password_cubit.dart';
import 'package:pet_groom/blocs/index_cubit.dart';
import 'package:pet_groom/core/api/api_client.dart';
import 'package:pet_groom/core/api/api_constants.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/repositories/auth_repository.dart';
import 'package:pet_groom/data/repositories/user_repository.dart';
import 'package:pet_groom/data/user_local_data_source.dart';
import 'package:pet_groom/domain/repositories/auth_repository.dart';
import 'package:pet_groom/domain/repositories/user_repository.dart';
import 'package:pet_groom/domain/usecase/auth_usecase.dart';
import 'package:pet_groom/domain/usecase/user_usecase.dart';

final getItInstance = GetIt.asNewInstance();

Future init() async {
  _configPlugins();
  _dataSources();
  _repositories();

  _useCases();
  _blocCubit();


}

void _configPlugins() {
  //connectivity
  getItInstance.registerLazySingleton<Connectivity>(
        () => Connectivity(),
  );

  //Dio
  // api
  getItInstance.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
      ),
    ),
  );

  //api client
  getItInstance.registerLazySingleton<ApiClient>(
        () => ApiClient(
      getItInstance(),
      getItInstance(),
    ),
  );
}
void _dataSources() {

  getItInstance.registerLazySingleton<AuthDataSource>(() => AuthDataSourceIMpl(getItInstance()/*,getItInstance()*/));
  getItInstance.registerLazySingleton<UserLocalDataSource>(
          () => UserLocalDataSourceImpl()
  );

}
void _repositories() {
  getItInstance.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getItInstance()));



}

Future<void> _useCases() async {

  getItInstance.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getItInstance()));
  getItInstance.registerLazySingleton<SignupUseCase>(() => SignupUseCase(getItInstance()));
  getItInstance.registerLazySingleton<UpdateProfileUC>(() => UpdateProfileUC(getItInstance()));

  getItInstance.registerLazySingleton<SaveUserUC>(() => SaveUserUC(getItInstance()));
  getItInstance.registerLazySingleton<GetUserUC>(() => GetUserUC(getItInstance()));
  getItInstance.registerLazySingleton<DeleteUserUC>(() => DeleteUserUC(getItInstance()));


}

void _blocCubit() {




 getItInstance.registerLazySingleton<IndexCubit>(() => IndexCubit());
 getItInstance.registerLazySingleton<AuthCubit>(() =>  AuthCubit(getItInstance(),getItInstance(),getItInstance(),getItInstance(),getItInstance()));

 getItInstance.registerLazySingleton<PasswordCubit>(() =>  PasswordCubit());



}

