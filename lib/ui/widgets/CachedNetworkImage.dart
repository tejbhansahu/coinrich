import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:coinrich/core/utils/images.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final String placeHolder;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Widget? placeholderWidget;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.placeHolder = Images.placeHolderImage,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholderWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      fit: fit,
      height: height,
      width: width,
      filterQuality: FilterQuality.medium,
      fadeInCurve: Curves.fastLinearToSlowEaseIn,
      fadeOutCurve: Curves.fastLinearToSlowEaseIn,
      placeholder: (_, __) =>
          placeholderWidget != null ? placeholderWidget! : _buildPlaceHolder(),
      errorWidget: (_, __, ___) =>
          placeholderWidget != null ? placeholderWidget! : _buildPlaceHolder(),
    );
  }

  Widget _buildPlaceHolder() => Image.asset(
        placeHolder,
        fit: fit,
        height: height,
        width: width,
      );
}
