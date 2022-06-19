import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/values/constant.dart';
import 'package:salon_provider/feature/values/string.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomerImageNetwork extends StatelessWidget {
  final String urlImage;
  final double widthNumber;
  final double heigthNumber;
  final double borderRadius;
  final bool circle;
  final Color borderColor;
  CustomerImageNetwork(
      this.urlImage, this.heigthNumber, this.widthNumber, this.borderRadius,
      {this.circle = true, this.borderColor = Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: baseImageUrl + urlImage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          //  borderRadius: BorderRadius.only(
          //                                   topLeft: Radius.circular(borderRadius),
          //                                   bottomLeft: Radius.circular(borderRadius)),
          border: Border.all(color: borderColor),
        ),
        child: circle
            ? CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(baseImageUrl + urlImage),
                maxRadius: borderRadius,
              )
            : Container(
                width: setW(widthNumber, context),
                height: setH(heigthNumber, context),
                decoration: BoxDecoration(
                  borderRadius: SPHelper.spHelper.getLanguge() != "ar"
                      ? BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          bottomLeft: Radius.circular(borderRadius))
                      : BorderRadius.only(
                          topRight: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      ),
      placeholder: (context, url) => Center(
          child: circle
              ? CircleAvatar(
                  backgroundImage: ExactAssetImage(loading),
                  maxRadius: borderRadius,
                )
              : Container(
                  width: setW(widthNumber, context),
                  height: setH(heigthNumber, context),
                  child: Image.asset(loading))),
      errorWidget: (context, url, error) => Center(
          child: Container(
        width: setW(90, context),
        height: setH(120, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey,
        ),
      )),
    );
  }
}
