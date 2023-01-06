import 'package:flutter/material.dart';

import '../../../../core/common/custom_elevated_button.dart';
import '../../../../core/common/text_field1.dart';
import '../../../../core/utilis/constants.dart';
import '../../controller/cubit/register_cubit.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.cubit,
    required this.nameController,
    required this.screenHeight,
    required this.phoneController,
    required this.emailController,
    required this.passController,
    required this.passConfirmController,
    required this.state,
  }) : super(key: key);

  final RegisterCubit cubit;
  final TextEditingController nameController;
  final double screenHeight;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController passConfirmController;
  final RegisterState state;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: AppConstants.signUpFormKey,
        child: Column(
          children: [
            CustomTextFieldR(
              cubit: cubit,
              controller: nameController,
              hintText: 'Name',
              textInputType: TextInputType.text,
              assetName: 'assets/images/Profile.svg',
            ),
            SizedBox(
              height: screenHeight * 0.019,
            ),
            CustomTextFieldR(
              cubit: cubit,
              controller: phoneController,
              hintText: 'Phone',
              textInputType: TextInputType.phone,
              assetName: 'assets/images/phone.svg',
            ),
            SizedBox(
              height: screenHeight * 0.019,
            ),
            CustomTextFieldR(
              cubit: cubit,
              controller: emailController,
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              assetName: 'assets/images/Message.svg',
            ),
            SizedBox(
              height: screenHeight * 0.019,
            ),
            CustomTextFieldR(
              cubit: cubit,
              controller: passController,
              hintText: 'Password',
              textInputType: TextInputType.text,
              assetName: 'assets/images/Lock.svg',
            ),
            SizedBox(
              height: screenHeight * 0.019,
            ),
            CustomTextFieldR(
              cubit: cubit,
              controller: passConfirmController,
              hintText: 'Confirm Password',
              textInputType: TextInputType.text,
              assetName: 'assets/images/Lock.svg',
              passController: passController,
              passConfirmcontroller: passConfirmController,
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            state is RegisterLoading
                ? const CircularProgressIndicator(
                    color: AppConstants.primaryColor,
                  )
                : CustomElevatedButton(
                    onPressed: () {
                      if (AppConstants.signUpFormKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        cubit.createUser(
                          emailController.text,
                          passController.text,
                          passConfirmController.text,
                          phoneController.text,
                          nameController.text,
                        );
                      }
                    },
                    text: 'Sign up',
                  ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
          ],
        ));
  }
}
