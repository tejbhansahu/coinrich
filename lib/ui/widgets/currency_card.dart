import 'package:coinrich/core/constant/colors.dart';
import 'package:coinrich/core/constant/styles.dart';
import 'package:coinrich/core/models/currency_list/currency_response.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({Key? key, required this.currency}) : super(key: key);

  final CryptoCurrencyResponse currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                currency.name ?? '',
                style: Styles.tsGreyRegular18,
              ),
              const SizedBox(width: 20.0),
              Row(
                children: [
                  Visibility(
                      visible: currency.volumeChange24H!.isNegative,
                      replacement: const Icon(Icons.arrow_upward,
                          color: AppColors.green, size: 18),
                      child: const Icon(Icons.arrow_downward,
                          color: AppColors.red, size: 18)),
                  Text(
                      "${currency.volumeChange24H?.toStringAsFixed(2).toString().replaceAll('-', '')}%",
                      style: Styles.tsGreyRegular12)
                ],
              ),
              const Spacer(),
              Container(
                width: 85.0,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: const BoxDecoration(
                    color: AppColors.detailCardColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Center(
                    child: Text(
                  currency.symbol?.toUpperCase() ?? '',
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
                )),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Text("Price 💲${currency.price!.toStringAsFixed(2)}", style: Styles.tsGreyRegular11),
              const Spacer(),
              const Icon(Icons.arrow_circle_right_rounded, color: AppColors.yellow)
            ],
          )
        ],
      ),
    );
  }
}
