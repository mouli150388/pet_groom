part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends AuthState {}
class LoadingState extends AuthState {}

class EmailErrorState extends AuthState {
  final String error;

   EmailErrorState({required this.error});
}


class PasswordErrorState extends AuthState {
  final String error;

  const PasswordErrorState({required this.error});
}

class NameErrorState extends AuthState {
  final String error;

  const NameErrorState({required this.error});
}
class NumberErrorState extends AuthState {
  final String error;

  const NumberErrorState({required this.error});
}class DOBError extends AuthState {
  final String error;

  const DOBError({required this.error});
}class CountryError extends AuthState {
  final String error;

  const CountryError({required this.error});
}

class ConfirmPasswordErrorState extends AuthState {
  final String error;

  const ConfirmPasswordErrorState({required this.error});
}
class SigninLoadingState extends AuthState {}

class SigninSuccessState extends AuthState {}

class SigninErrorState extends AuthState {
}

class SignupLoadingState extends AuthState {
}
class SignupLoadedState extends AuthState {
}

class LoadedUserData extends AuthState {
  UserEntity userEntity;
  LoadedUserData(this.userEntity);
}


class ErrorState extends AuthState {
  final String error;

  const ErrorState({required this.error});
}

class LogoutErrorState extends AuthState {
  final String error;

  const LogoutErrorState({required this.error});
}
class SuccessState extends AuthState {
}

class LogoutSuccessState extends AuthState {
}

class PasswordVisibilityChange extends AuthState {

  PasswordVisibilityChange();
}
class ForgotLoading extends AuthState {

  ForgotLoading();
}
class ForgotSuccess extends AuthState {

  ForgotSuccess();
}
class ForgotFailure extends AuthState {

  ForgotFailure();
}