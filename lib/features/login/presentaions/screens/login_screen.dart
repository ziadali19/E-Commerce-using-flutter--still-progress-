import 'package:e_commerce/core/utilis/cashe_helper.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/cart/controller/cubit/cart_cubit.dart';
import 'package:e_commerce/features/home/controller/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/presentation/layouts/home_layout_screen.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locator.dart';

import '../../../favorite/controller/cubit/favorite_cubit.dart';
import '../../../settings/controller/cubit/address_cubit.dart';
import '../../../settings/controller/cubit/my_account_cubit.dart';
import '../../../settings/controller/cubit/orders_cubit.dart';
import '../../controller/cubit/login_cubit.dart';
import '../../controller/cubit/login_state.dart';
import '../components/going_to_signup.dart';
import '../components/login_form.dart';
import '../components/logo_and_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
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
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        AppConstants().showSnackBar(
                            'You are successfully logged in',
                            context,
                            Colors.green);
                        CasheHelper.saveData('token',
                                LoginCubit.get(context).model?.accessToken)
                            .then((value) {
                          token = LoginCubit.get(context).model?.accessToken;

                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeLayoutScreen(),
                          ));
                          HomeCubit.get(context).getActiveUserData(token);
                          HomeCubit.get(context).getHomeProducts();
                          CartCubit.get(context).getUserCart(token);
                          FavoriteCubit.get(context).getFavorites(token!, 1);
                          MyAccountCubit.get(context).getActiveUserData(token);
                        });
                      }
                      if (state is LoginError) {
                        AppConstants()
                            .showSnackBar(state.message, context, Colors.red);
                      }
                    },
                    builder: (context, state) {
                      LoginCubit cubit = LoginCubit.get(context);
                      return LoginForm(
                          state: state,
                          cubit: cubit,
                          emailController: emailController,
                          screenHeight: screenHeight,
                          passController: passController);
                    },
                  ),
                  GoingToSignUp(screenWidth: screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
