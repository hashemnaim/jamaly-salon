import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class HomeCategoryItem extends StatefulWidget {
  final String imageName, title;
  Color color;
  HomeCategoryItem({
    this.imageName,
    this.title,
    this.color,
  });

  @override
  State<HomeCategoryItem> createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Expanded(
              child: CachedNetworkImage(
            imageUrl: widget.imageName,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                  // colorFilter: ColorFilter.mode(Colors.white, BlendMode.hardLight)
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.error),
              ),
            ),
          )),

          // CachedNetworkImageShare(imageName, 55.h, 55.w, 0),

          // Figma Flutter Generator HaircutWidget - TEXT
          CustomText(
            text: widget.title,
            color: widget.color,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
