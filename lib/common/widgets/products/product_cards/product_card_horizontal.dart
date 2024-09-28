import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/products/t_rounded_container.dart';
import 'package:t_store/common/widgets/text/product_title_text.dart';
import 'package:t_store/common/widgets/text/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/common/widgets/text/t_product_price_text.dart';
import 'package:t_store/features/shop/screens/product_details/product_detail.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.productImageRadius),
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.lightContainer),
          child: Row(
            children: [
              //thumbnail
              TRoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    // Thumbnail image
                    const SizedBox(
                        height: 120,
                        width: 120,
                        child: TRoundedImage(
                          imageUrl: TImages.productImage1,
                          applyImageRadius: true,
                        )),

                    //sale tag
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '25%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),

//favorite icon button
                    const Positioned(
                        top: 0,
                        right: 0,
                        child: TCircularIcon(
                          icon: Iconsax.heart5,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
              //details
              SizedBox(
                width: 172,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: TSizes.sm, left: TSizes.sm),
                  child: Column(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TProductTitleText(
                            title: 'Green Nike Half Sleeves Shirt',
                            smallSize: true,
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          TBrandTitleWithVerifiedIcon(title: 'Nike'),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //pricing
                          const Flexible(
                              child:
                                  TProductPriceText(price: '256.0')),
              
                          //add to cart button
                          Container(
                            decoration: const BoxDecoration(
                                color: TColors.dark,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        TSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        TSizes.productImageRadius))),
                            child: const SizedBox(
                                width: TSizes.iconLg * 1.2,
                                height: TSizes.iconLg * 1.2,
                                child: Center(
                                    child: Icon(
                                  Iconsax.add,
                                  color: TColors.white,
                                ))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
