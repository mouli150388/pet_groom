import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexCubit extends Cubit<int> {
  static int indexValue = 0;

  IndexCubit() : super(indexValue);

  void change(int value) {
    indexValue = value;
    emit(indexValue);
  }

  void currentIndex(int value) => emit(value);
}

class MarkerChangeCubit extends Cubit<int> {


  MarkerChangeCubit() : super(0);

  void change() async{
  /*  await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(22, 22)),
        'assets/marker.png')
        .then((d) {
     ApiConstants.customIcon=d;
     print("Loading BitmapDiscriptor");
     print("Loading BitmapDiscriptor ${d is BitmapDescriptor}");
    });*/
  }


}