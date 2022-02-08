import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:pet_groom/core/app_assets.dart';
import 'package:pet_groom/core/screen_utils.dart';

class LoadingCircle extends StatelessWidget {
  final double? size;

  const LoadingCircle({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 200.sp,
      height: size ?? 200.sp,
      child: const FlareActor(
        AppAssets.loadingCircle,
        animation: 'load',
        snapToEnd: true,
      ),
    );
  }
}
