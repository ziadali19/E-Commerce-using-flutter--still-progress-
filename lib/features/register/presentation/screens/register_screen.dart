import 'package:e_commerce/core/utilis/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../login/presentaions/components/logo_and_title.dart';
import '../../../login/presentaions/screens/login_screen.dart';
import '../../controller/cubit/register_cubit.dart';
import '../components/going_to_login.dart';
import '../components/register_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passConfirmController.dispose();
    passController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogoAndTitle(
                      screenHeight: screenHeight, screenWidth: screenWidth),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess &&
                          RegisterCubit.get(context).model?.status ==
                              'success') {
                        AppConstants().showSnackBar(
                            RegisterCubit.get(context).model?.message,
                            context,
                            Colors.green);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      }
                      if (state is RegisterError) {
                        AppConstants()
                            .showSnackBar(state.message, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      RegisterCubit cubit = RegisterCubit.get(context);
                      return RegisterForm(
                          state: state,
                          cubit: cubit,
                          nameController: nameController,
                          screenHeight: screenHeight,
                          phoneController: phoneController,
                          emailController: emailController,
                          passController: passController,
                          passConfirmController: passConfirmController);
                    },
                  ),
                  GoingToLogin(screenWidth: screenWidth)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
