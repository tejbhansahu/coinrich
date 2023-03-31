import 'package:flutter/material.dart';
import 'package:coinrich/core/constant/colors.dart';
import 'package:coinrich/ui/widgets/shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return AspectRatio(
              aspectRatio: 3 / 2,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  color: AppColors.shimmerCardColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                        aspectRatio: 2.35 / 1, child: shimmer(size: size)),
                    const SizedBox(height: 10.0),
                    Container(
                        height: 20.0,
                        width: size.width * .4,
                        padding: const EdgeInsets.only(left: 10.0),
                        child: shimmer(size: size)),
                    Container(
                        height: 20.0,
                        width: size.width * .7,
                        margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: shimmer(size: size))
                  ],
                ),
              ));
        });
  }
}
