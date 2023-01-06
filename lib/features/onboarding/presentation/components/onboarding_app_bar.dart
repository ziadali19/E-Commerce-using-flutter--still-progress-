import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utilis/cashe_helper.dart';
import '../../../login/presentaions/screens/login_screen.dart';

AppBar onBoardingAppBar(BuildContext context) {
  return AppBar(
    actions: [
      TextButton(
          onPressed: () {
            CasheHelper.saveData('onBoarding', true).then((value) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            });
          },
          child: Text(
            'Skip',
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ))
    ],
  );
}
