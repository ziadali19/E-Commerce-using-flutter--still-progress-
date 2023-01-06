import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/cubit/filter_cubit.dart';

class FilterListViewItem extends StatelessWidget {
  const FilterListViewItem({
    Key? key,
    required this.cubit,
    required this.index,
    required this.onTap,
    required this.color,
    required this.name,
  }) : super(key: key);

  final FilterCubit cubit;
  final int index;
  final Function() onTap;
  final Color? color;
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          color: color,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
