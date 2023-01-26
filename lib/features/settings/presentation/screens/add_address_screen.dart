import 'package:e_commerce/core/common/custom_elevated_button.dart';
import 'package:e_commerce/core/utilis/constants.dart';
import 'package:e_commerce/features/categories/presentaion/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/address_cubit.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is GetAddressError) {
          AppConstants().showSnackBar(state.errorMsg, context, Colors.red);
        }
        if (state is GetAddressSuccess) {
          AppConstants().showSnackBar(
              'Your Address is added successfully', context, Colors.green);
        }
      },
      builder: (context, state) {
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        TextEditingController countryController = TextEditingController();
        TextEditingController stateController = TextEditingController();
        TextEditingController cityController = TextEditingController();
        TextEditingController addressDetailsController =
            TextEditingController();

        AddressCubit cubit = AddressCubit.get(context);
        cubit.addressModel != null
            ? countryController.text = cubit.addressModel!.country!
            : countryController.text = '';
        cubit.addressModel != null
            ? stateController.text = cubit.addressModel!.state!
            : stateController.text = '';
        cubit.addressModel != null
            ? cityController.text = cubit.addressModel!.city!
            : cityController.text = '';
        cubit.addressModel != null
            ? addressDetailsController.text =
                cubit.addressModel!.addressDetails!
            : addressDetailsController.text = '';
        return Scaffold(
          appBar: customAppBar(context, 'Add Address'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: ListView(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Country',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          controller: countryController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please Enter Your Country';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Governorate',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          controller: stateController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please Enter Your Governorate';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          controller: cityController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please Enter Your City';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Address Details',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          controller: addressDetailsController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please Enter Your Address Details';
                            }
                          },
                        ),
                        SizedBox(
                          height: 55.h,
                        ),
                        state is GetAddressLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomElevatedButton(
                                text: 'Add',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.addAddress(
                                        countryController.text,
                                        stateController.text,
                                        cityController.text,
                                        addressDetailsController.text);
                                  }
                                })
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
