import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';


class ConnectivityCubit extends Cubit<bool> {
  final Connectivity _connectivity;

  ConnectivityCubit(this._connectivity) : super(true);

  Future<void> checkConnectivity() async {
    emit(await _connectivity.checkConnectivity() != ConnectivityResult.none);
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {

      if (result == ConnectivityResult.none) {
        emit(false);
      } else {
        emit(true);
      }
    });
  }
}