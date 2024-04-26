import '../../../../../data/controllers/database_controller.dart';
import '../../../../../data/controllers/home/details_controller.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helpers.dart';
import '../../../common/custom_appbar.dart';
import '../../../common/custom_listview.dart';
import '../../../common/custom_rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final List<String> productImages = product.productImages!;
    final detailsController = DetailsController.instance;
    final dbController = DatabaseController.instance;
    final isFavorite = dbController.checkFavoritesList(product.productId!).obs;

    return SizedBox(
      width: double.infinity,
      height: MyHelpers.getResponsiveHeight(330),
      child: Stack(
        children: [
          // -- Main Image
          Obx(
            () => Image.network(
              height: MyHelpers.getResponsiveHeight(330),
              width: double.infinity,
              detailsController.selectedImage.value != ""
                  ? detailsController.selectedImage.value
                  : productImages[0],
              fit: BoxFit.fill,
            ),
          ),

          // -- App bar
          CustomAppBar(
            showBackArrow: true,
            actions: [
              Obx(
                () => IconButton(
                  onPressed: () async {
                    if (isFavorite.value) {
                      dbController.removeFromFavorites(product.productId!);
                      isFavorite.value = false;
                    } else {
                      await dbController.addToFavorites(product);
                      isFavorite.value = true;
                    }
                  },
                  icon: Icon(
                    isFavorite.value
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          // -- Other Images
          Positioned(
            bottom: MySizes.spaceBtwItems / 2,
            right: 0,
            left: 5,
            child: SizedBox(
              height: 70,
              child: CustomListView(
                itemCount: productImages.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (c, i) =>
                    const SizedBox(width: MySizes.spaceBtwItems / 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      detailsController.selectedImageIndex.value = index;
                      detailsController.selectedImage.value =
                          productImages[index];
                    },
                    child: Obx(
                      () => CustomRoundedImage(
                        isSvg: false,
                        isNetworkImage: true,
                        boxFit: BoxFit.fill,
                        width: 70,
                        height: 70,
                        borderRadius: MySizes.md,
                        image: productImages[index],
                        borderColor:
                            detailsController.selectedImageIndex.value == index
                                ? Colors.blue
                                : Colors.grey,
                        borderWidth:
                            detailsController.selectedImageIndex.value == index
                                ? 2
                                : 1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
