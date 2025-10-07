import 'package:flutter/material.dart';
import 'package:natie_portfolio/global/dimens.dart';

import 'content_item.dart';

class ImageView extends StatelessWidget {
  final String src;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final VoidCallback? onFinish;

  const ImageView(
    this.src, {
    super.key,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider img;
    if (src.startsWith('http')) {
      img = NetworkImage(src);
    } else {
      img = AssetImage(src);
    }
    img
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((_, _) => onFinish?.call()));
    return Image(
      image: img,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        return (progress == null)
            ? child
            : SizedBox(
                width: width,
                height: height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColorLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                              progress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                ),
              );
      },
      errorBuilder: (context, exception, stackTrace) {
        return errorWidget ?? const Nothing();
      },
    );
  }
}

class CircleImageView extends StatelessWidget {
  final String src;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final VoidCallback? onFinish;

  const CircleImageView(
    this.src, {
    super.key,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ImageView(
        src,
        errorWidget: errorWidget,
        width: width,
        height: height,
        fit: fit,
        onFinish: onFinish,
      ),
    );
  }
}

class RoundedImageView extends StatelessWidget {
  final String src;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final VoidCallback? onFinish;
  final BorderRadius borderRadius;

  const RoundedImageView(
    this.src, {
    super.key,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onFinish,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(Dimens.roundedImageRadius)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ImageView(
        src,
        errorWidget: errorWidget,
        width: width,
        height: height,
        fit: fit,
        onFinish: onFinish,
      ),
    );
  }
}

class SvgImageView extends StatelessWidget {
  final String src;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SvgImageView(
    this.src, {
    super.key,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return ImageView(src,
        errorWidget: errorWidget, width: width, height: height, fit: fit);
  }
}