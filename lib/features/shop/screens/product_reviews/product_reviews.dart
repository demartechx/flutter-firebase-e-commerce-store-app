
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/ratings/rating_indicator.dart';
import 'package:t_store/features/shop/screens/product_reviews/widgets/overall_product_rating.dart';
import 'package:t_store/utils/constants/sizes.dart';

import 'widgets/user_review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      //appbar
      appBar: const TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ratings and Reviews are verified and are from people who use the same type of device that you use'),
              const SizedBox(height: TSizes.spaceBtwItems,),

              //overall product ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 3.5,),
              Text("12,611", style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //user reviews list
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard()


            ],
          ),
        
        ),

      ),
    );
  }
}



