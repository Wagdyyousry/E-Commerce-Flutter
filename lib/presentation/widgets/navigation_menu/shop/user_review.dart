import 'package:ecommerce/data/models/review_model.dart';
import 'package:ecommerce/presentation/widgets/common/custom_circular_image.dart';
import 'package:ecommerce/presentation/widgets/common/custom_rounded_container.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/formatters/formaters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class UserReview extends StatelessWidget {
  const UserReview({super.key, required this.review});
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedContainer(
      backgroundColor: Colors.grey.withOpacity(0.1),
      padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- User Info
          ListTile(
            contentPadding: const EdgeInsets.all(0),

            // -- User image
            leading: CustomCircularImage(
              width: 50,
              height: 50,
              isNetworkImage: review.userImageUri != null ? true : false,
              isSvg: false,
              image: review.userImageUri ?? MyImages.userImage,
              enableBorder: true,
              borderColor: Colors.grey,
            ),
            // -- User name
            title: Text(
              review.userName!,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwItems / 2),

          // -- Use rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBarIndicator(
                itemCount: 5,
                itemSize: 20,
                rating: review.rating!,
                unratedColor: Colors.grey,
                itemBuilder: (context, index) => const Icon(
                  Icons.star_rounded,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: MySizes.spaceBtwItems / 2),

              // -- rating date
              Text(
                MyFormatters.fromDateToDayesMonthsYears(
                    review.reviewDate!.toInt()),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwItems),

          // -- User Comment
          if (review.review != null)
            ReadMoreText(
              textAlign: TextAlign.start,
              review.review!,
              //"I have use this app entirly and tried every single feature of it and i'm ready to say it is Awesom,I have use this app entirly and tried every single feature of it and i'm ready to say it is Awesom,I have use this app entirly and tried every single feature of it and i'm ready to say it is Awesom",
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: "Read More",
              trimExpandedText: "Less",
              moreStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
              lessStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
            ),
          const SizedBox(height: MySizes.spaceBtwItems),

          // -- Store Response
          if (review.reply != null)
            CustomRoundedContainer(
              radius: 10,
              padding: const EdgeInsets.all(MySizes.defaultSpace / 2),
              backgroundColor: Colors.grey.withOpacity(0.5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // -- Store name
                      Text(
                        "MyShop",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // -- Response data
                      Text(
                        "27-nov-2022 ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  // -- Store Response
                  const ReadMoreText(
                    "Thank you for your review , we apperciate that so much and for that we offer you 3 pieces in the price of one 555555555555555555555555555555555555555555555555  ",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Read More",
                    trimExpandedText: "Less",
                    moreStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                    lessStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
