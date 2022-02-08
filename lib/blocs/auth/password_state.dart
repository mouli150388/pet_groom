part of 'password_cubit.dart';

@immutable
abstract class PasswordState {
  const PasswordState();
}

class PasswordInitial extends PasswordState {}
class PasswordVisibilityChange extends PasswordState {
  bool value;
  PasswordVisibilityChange(this.value);
}
