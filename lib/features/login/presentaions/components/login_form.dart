import 'package:e_commerce/features/forget%20password/presentation/screens/forget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/text_field.dart';
import '../../../../core/utilis/constants.dart';
import '../../controller/cubit/login_cubit.dart';
import '../../controller/cubit/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.cubit,
    required this.emailController,
    required this.screenHeight,
    required this.passController,
    required this.state,
  }) : super(key: key);

  final LoginCubit cubit;
  final TextEditingController emailController;
  final double screenHeight;
  final TextEditingController passController;
  final LoginState state;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: AppConstants.signInFormKey,
        child: Column(
          children: [
            CustomTextField(
              cubit: cubit,
              controller: emailController,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              assetName: 'assets/images/Message.svg',
            ),
            SizedBox(
              height: screenHeight * 0.019,
            ),
            CustomTextField(
              cubit: cubit,
              controller: passController,
              hintText: 'Password',
              textInputType: TextInputType.text,
              assetName: 'assets/images/Lock.svg',
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForgetScreen()));
                    },
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff230A06)),
                    )),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            state is LoginLoading
                ? const CircularProgressIndicator(
                    color: AppConstants.primaryColor,
                  )
                : CustomElevatedButton(
                    onPressed: () {
                      if (AppConstants.signInFormKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        cubit.userLogin(
                          emailController.text,
                          passController.text,
                        );
                      }
                    },
                    text: 'Log in',
                  ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
          ],
        ));
  }
}
