import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.cardType,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expireDate,
    required this.colors,
    required this.amount,
    required this.voidCallback,
  });

  final String cardType;
  final String cardNumber;
  final String cardHolderName;
  final String expireDate;
  final String amount;
  final List<Color> colors;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onLongTap: voidCallback,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16,
          ),
          border: Border.all(
            color: AppColors.white,
            width: 2.w,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.cipPng,
                    width: 40.w,
                    height: 30.h,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    cardType,
                    style: AppTextStyle.interBold.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 23.w,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                cardNumber,
                style: AppTextStyle.interBold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.w,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Text(
                    'KARTA HISOBI:',
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.white,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    amount,
                    style: AppTextStyle.interBold.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.w,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CARD HOLDER NAME",
                        style: AppTextStyle.interBold.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.w,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        cardHolderName,
                        style: AppTextStyle.interBold.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.w,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPIRE DATA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        expireDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
