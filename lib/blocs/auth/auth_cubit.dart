import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


import 'package:pet_groom/core/extensions/common_extension.dart';
import 'package:pet_groom/data/auth_datasource.dart';
import 'package:pet_groom/data/result.dart';
import 'package:pet_groom/di/dependency_injection.dart';
import 'package:pet_groom/domain/entities/app_error.dart';
import 'package:pet_groom/domain/entities/no_params.dart';
import 'package:pet_groom/domain/entities/request/loginrequest.dart';
import 'package:pet_groom/domain/entities/request/profile_request.dart';
import 'package:pet_groom/domain/entities/request/signup_request.dart';
import 'package:pet_groom/domain/entities/user_entity.dart';
import 'package:pet_groom/domain/usecase/auth_usecase.dart';
import 'package:pet_groom/domain/usecase/user_usecase.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  bool showError=true;
  LoginUseCase loginUseCase;
  SignupUseCase signupUseCase;
  DeleteUserUC deleteUserUC;
  GetUserUC getUserUC;
  UpdateProfileUC updateProfileUC;

  AuthCubit(this.loginUseCase,this.signupUseCase,this.deleteUserUC,this.getUserUC,this.updateProfileUC) : super(LoginInitial());

  Future<void> signinValidate({required LoginRequestParams params,required BuildContext context}) async {
    emit(LoadingState());
    if (!params.email.isValidEmail()) {
      emit( EmailErrorState(error: "${AppLocalizations.of(context)?.enter_valid_email}"));
    }else if (!params.password.isValidPassword()) {
      emit( PasswordErrorState(
          error: "${AppLocalizations.of(context)?.password_should_be}"));
    }
    else
      {
        final Either<AppError, Result> response = await loginUseCase(params);
        emit(response.fold(
              (l) => ErrorState(error: l.error),
              (r) => SigninSuccessState(),
        ));
      }


  }


  Future<void> logoutUser() async {
    emit(LoadingState());

    final Either<AppError, dynamic> response = await deleteUserUC(NoParams());
    emit(response.fold(
          (l) => LogoutErrorState(error: l.error),
          (r) => LogoutSuccessState(),
    ));

  }


  Future<void> signUpValue(
      SignupRequestParams params,BuildContext context) async {
    showError = true;
    emit(LoadingState());
    if (showError) {
      if (!params.name.isValidName()) {
        emit(NameErrorState(error:"${AppLocalizations.of(context)?.enter_valid_name} "));
      } else if (!validateMobile(params.phone)||!params.phone.isValidName()) {
        emit(NumberErrorState(error:"${AppLocalizations.of(context)?.enter_valid_number}"));
      } else if (!params.email.isValidEmail()) {
        emit( EmailErrorState(error: "${AppLocalizations.of(context)?.enter_valid_email}"));
      }else if (!params.dob.isValidDob()) {
        emit( DOBError(error: "${AppLocalizations.of(context)?.enter_valid_date} "));
      }else if (params.user_country_code.isEmpty) {
        emit( CountryError(error: "${AppLocalizations.of(context)?.select_country} "));
      } else if (!params.password.isValidPassword()) {
        emit(PasswordErrorState(
            error: "${AppLocalizations.of(context)?.password_should_be}"));
      }  else {
        final Either<AppError, dynamic> response =
        await signupUseCase(params);
        emit(response.fold(
              (l) => ErrorState(error: l.error),
              (r) => SuccessState(),
        ));
      }
    }
  }
  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
     return false;
    }
    else if (!regExp.hasMatch(value)) {
     return false;
    }
    return true;
  }

  Future<void>getUserDetails()async{
    final user=await getUserUC.call(NoParams());
    print("User Logged ${user}");
    (user.fold((l) => {
        emit(ErrorState(error: ''))
    }, (r) => {
      if(r!=null)
        {
        emit(LoadedUserData(r))
        }else
          {
            emit(ErrorState(error: ''))
          }
    }));
  }

  Future<void>setImage(UserEntity entity) async{
    emit(LoadedUserData(entity));
  }
  Future<void>updateProfile(ProfileRequestParams params) async{
    emit(LoadingState());
    final user=await updateProfileUC.call(params);
    print("Profile Update 1 ${user}");
    (user.fold((l) => {
      emit(ErrorState(error: ''))
    }, (r) => {
      if(r!=null)
        {
          emit(SuccessState())
        }else
        {
          emit(ErrorState(error: ''))
        }
    }));
  }


  Future<void> sendForgotPass(
      Map<String,dynamic> params) async {
    showError = true;
    emit(ForgotLoading());


    AuthDataSource authDatasource=getItInstance();

    var result=await authDatasource.sendPassword(params);
    if(result.status==5)
    {
      emit(ForgotSuccess());
     /* Fluttertoast.showToast(
          msg: "Password sent to EmailId",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.technoPrimary,
          textColor: Colors.white,
          fontSize: 16.0
      );*/
    }else
    {
      emit(ForgotFailure());
      /*Fluttertoast.showToast(
          msg: "User Not found with given email id!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.technoPrimary,
          textColor: Colors.white,
          fontSize: 16.0
      );*/
    }

  }

}

class CheckBoxCubit extends Cubit<bool> {
  var isChecked=false;
  CheckBoxCubit({required this.isChecked}) : super(true);

  Future<void> change(bool value) async {
    this.isChecked=value;
    emit(value);
  }
}