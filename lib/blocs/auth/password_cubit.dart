import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<bool> {
  PasswordCubit() : super(true);

  Future<void> change(bool value) async {
    emit(value);
  }


}

class ExpandCubit extends Cubit<bool> {
  ExpandCubit() : super(false);

  Future<void> change(bool value) async {
    emit(value);
  }


}


