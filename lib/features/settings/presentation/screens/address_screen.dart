import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/categories/presentaion/components/category_details_shimmer_effect.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:e_commerce/features/home/controller/cubit/home_cubit.dart';
import 'package:e_commerce/features/settings/presentation/screens/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controller/cubit/address_cubit.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is GetAddressError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
      },
      builder: (context, state) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        AddressCubit cubit = AddressCubit.get(context);
        return Scaffold(
          appBar: customAppBar(context, 'Addresses'),
          body: cubit.addressModel == null
              ? categoryDetailsShimmerEffect(screenHeight, screenWidth)
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    children: [
                      cubit.addressModel!.addressDetails == null
                          ? Center(
                              child: Text(
                              'No Address is Added Yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w400),
                            ))
                          : SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.r)),
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7.h, horizontal: 7.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(cubit.addressModel!.country!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(cubit.addressModel!.state!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(cubit.addressModel!.city!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                              cubit.addressModel!
                                                  .addressDetails!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                              HomeCubit.get(context)
                                                  .userModel!
                                                  .data
                                                  .phone!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        child: SvgPicture.asset(
                                            'assets/images/edit.svg'),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const AddAddressScreen(),
                                          ));
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const Spacer(),
                      cubit.addressModel!.addressDetails == null
                          ? CustomElevatedButton(
                              text: 'Add Your Address',
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddAddressScreen(),
                                ));
                              })
                          : const SizedBox()
                    ],
                  ),
                ),
        );
      },
    );
  }
}
