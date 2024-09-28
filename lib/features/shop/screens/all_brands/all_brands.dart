
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brand/t_brand_card.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/text/section_heading.dart';
import 'package:t_store/features/shop/screens/all_brands/brand_products.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: const TAppBar(title: Text('Brand'),showBackArrow: true,),
body: SingleChildScrollView(
  child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
  child: Column(
    children: [
      //heading
      const TSectionHeading(title: 'Brands', showActionButton: false,),
      const SizedBox(height: TSizes.spaceBtwItems,),

      //brands
      TGridLayout(
        mainAxisExtent: 80,
        itemCount: 10, itemBuilder: (context, index) => TBrandCard(showBorder: true, onTap: () => Get.to(()=> const BrandProducts()),)),



    ],
  ),
  
  ),
),
    );
  }
}