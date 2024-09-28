import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/products/cart/add_remove_button.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/text/t_product_price_text.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key, this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (_, index) =>  Column(
              children:  [
                const TCartItem(),
               if(showAddRemoveButtons) const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                //add remove button
                if(showAddRemoveButtons)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                         TProductQuantityWithAddAndRemoveButton(),
                      ],
                    ),
          
                    
                   
                    TProductPriceText(price: '256')
                    
                  ],
                )
              ],
            ),
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
       );
  }
}

