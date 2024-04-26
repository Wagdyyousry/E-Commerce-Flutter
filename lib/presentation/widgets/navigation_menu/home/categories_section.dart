import 'package:ecommerce/presentation/screens/navigation_menu/home/subcategories_screen.dart';
import 'package:ecommerce/presentation/widgets/common/custom_circular_image.dart';
import 'package:ecommerce/presentation/widgets/common/custom_listview.dart';
import 'package:ecommerce/utils/constants/my_images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GategoriesSection extends StatelessWidget {
  const GategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> categoriesImages = MyImages.categoriesImage;
    return SizedBox(
      height: MyHelpers.getResponsiveHeight(70),
      child: CustomListView(
        separatorBuilder: (context, index) => const SizedBox(),
        itemCount: categoriesImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () => Get.to(() => const SubCategoriesScreen()),
          child: Padding(
            padding: const EdgeInsets.only(left: MySizes.spaceBtwItems),
            child: Column(
              children: [
                // -- Category Image
                CustomCircularImage(
                  image: categoriesImages[index],
                  isSvg: true,
                  isNetworkImage: false,
                  padding: 2,
                  height: 45,
                  width: 45,
                ),
                const SizedBox(height: MySizes.spaceBtwItems / 3),

                // -- Category title
                SizedBox(
                  width: MyHelpers.getResponsiveWidth(50),
                  child: Text(
                    MyTexts.categoriesNames[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
