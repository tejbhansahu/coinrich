import 'package:coinrich/core/constant/colors.dart';
import 'package:coinrich/core/constant/styles.dart';
import 'package:coinrich/ui/views/home/provider.dart';
import 'package:coinrich/ui/widgets/app_bar.dart';
import 'package:coinrich/ui/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  fetchCurrencies() async {
    await Provider.of<HomeProvider>(context, listen: false).getCurrencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCurrencies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: customAppBar(),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.pie_chart_outline_rounded,
                            color: AppColors.yellow),
                        const SizedBox(width: 10.0),
                        Text('Show chart',
                            style: Styles.tsGreyRegular12
                                .copyWith(color: AppColors.yellow))
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Count: ${value.list.length}',
                      style: Styles.tsGreyRegular12,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: value.list.length,
                    itemBuilder: (context, index) {
                      return CurrencyCard(currency: value.list[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10.0)),
              ),
            ],
          );
        }
      }),
    );
  }
}
