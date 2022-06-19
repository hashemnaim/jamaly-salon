import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_image.dart';

class RateProductScreen extends StatefulWidget {
  final String userId;
  final Map map;

  RateProductScreen({Key key, this.userId, this.map}) : super(key: key);

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  int rate = 3;

  double rating = 3.5;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 23.h,
        ),

        StatefulBuilder(
          builder: (context, setState) => StarRating(
            rating: rating,
            onRatingChanged: (rating) => setState(() => this.rating = rating),
          ),
        ),
        SizedBox(
          height: 18.h,
        ),
        // CustomTextFormField(
        //   hintText: 'تعليق',
        //   textEditingController:controller
        // ),
        SizedBox(
          height: 25.h,
        ),
        CustomButton(
          onPress: () {
            ServerProvider.instance
                .setAddReview(widget.userId, rate.toString());
          },
          text: 'Done',
        )
      ],
    );
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Color color;
    if (index >= rating) {
      color = Color(0xffDBDEE4);
    } else {
      color = Color(0xffFFC831);
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 45.0.w,
        height: 45.0.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: Colors.white,
        ),
        child: CustomSvgImage(
          imageName: 'star_Icon4',
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
