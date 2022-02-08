import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;
  final String error;

  const AppError(this.appErrorType, {this.error = 'NIL'});

  String get errorType => appErrorType.toString();

  @override
  List<Object> get props => [appErrorType];
}

enum AppErrorType { api, network, database, unauthorised, sessionDenied }
