import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gold_express/app/core/app_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            //color: Colors.white,
            shape: BoxShape.rectangle,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black26,
            //   )
            // ],
          ),
          child: const Center(
            child: SpinKitPouringHourGlassRefined(
              color: AppColors.primary,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
