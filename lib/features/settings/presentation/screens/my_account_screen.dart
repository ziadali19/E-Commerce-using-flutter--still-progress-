import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/core/utilis/cashe_helper.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/home/controller/cubit/home_cubit.dart';
import 'package:e_commerce/features/home/controller/cubit/home_layout_cubit.dart';
import 'package:e_commerce/features/login/presentaions/screens/login_screen.dart';
import 'package:e_commerce/features/settings/controller/cubit/orders_cubit.dart';
import 'package:e_commerce/features/settings/presentation/screens/address_screen.dart';
import 'package:e_commerce/features/settings/presentation/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commerce/core/services/service_locator.dart';

import '../../../cart/controller/cubit/cart_cubit.dart';
import '../../../favorite/controller/cubit/favorite_cubit.dart';
import '../../controller/cubit/address_cubit.dart';
import '../../controller/cubit/my_account_cubit.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAccountCubit, MyAccountState>(
      listener: (context, state) {
        if (state is UserLogOutError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is UserLogOutSuccess) {
          AppConstants().showSnackBar(
              'You are successfully logged out', context, Colors.green);
          CasheHelper.removeData('token');
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));

          HomeLayoutCubit.get(context).currentIndex = 0;
        }
      },
      builder: (context, state) {
        MyAccountCubit cubit = MyAccountCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state is MyAccountGetActiveUserDataLoading
                  ? const LinearProgressIndicator(
                      color: AppConstants.primaryColor)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${cubit.userModel!.data.name!}',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          cubit.userModel!.data.email!,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
              Container(
                color: AppConstants.primaryColor,
                width: double.infinity,
                height: 1.5,
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                onTap: () {
                  OrdersCubit.get(context).getUserOrders();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrdersScreen(),
                  ));
                },
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                horizontalTitleGap: 0,
                leading: Container(
                    transform: Matrix4.translationValues(0, -2.5, 0),
                    child: SvgPicture.asset('assets/images/orders.svg')),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
                title: Text('Orders',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 15.h,
              ),
              ListTile(
                onTap: () {
                  AddressCubit.get(context).getAddress();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddressScreen(),
                  ));
                },
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                horizontalTitleGap: 0,
                leading: Container(
                    transform: Matrix4.translationValues(0, -2.5, 0),
                    child: SvgPicture.asset('assets/images/address.svg')),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
                title: Text('Addresses',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: state is UserLogOutLoading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        onPressed: () {
                          cubit.userLogOut();
                        },
                        text: 'Sign Out',
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
