import 'package:coinrich/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:coinrich/core/constant/colors.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    title: Text('CoinRich',
        style: Styles.tsGreyRegular18.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0)),
    centerTitle: true,
    elevation: 10.0,
    backgroundColor: AppColors.black,
  );
}
