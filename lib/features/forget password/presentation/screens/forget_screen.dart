import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/core/common/text_field.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/forget%20password/controller/cubit/forget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController forgetEmailController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocConsumer<ForgetCubit, ForgetState>(
        listener: (context, state) {
          if (state is ForgetSuccess) {
            AppConstants().showSnackBar(
                ForgetCubit.get(context).successMsg, context, Colors.green);
          }
          if (state is ForgetError) {
            AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: SvgPicture.asset(
                    'assets/images/forget.svg',
                    width: 400.w,
                    height: 400.h,
                  )),
                  Text(
                    'Forgot\nPassword?',
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                      'Don’t worry ! It happens. Please enter your email and we will send the verfication code to this email.',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff5B5858))),
                  SizedBox(
                    height: 27.h,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: forgetEmailController,
                            hintText: 'Enter your E-mail',
                            textInputType: TextInputType.emailAddress,
                            assetName: 'assets/images/Message.svg',
                          ),
                          SizedBox(
                            height: 41.h,
                          ),
                          state is ForgetLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomElevatedButton(
                                  text: 'Continue',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ForgetCubit.get(context).forgetPassword(
                                          forgetEmailController.text.trim());
                                    }
                                  })
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
