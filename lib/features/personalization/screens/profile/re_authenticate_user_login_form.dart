


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/controllers/update_name_controller.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        leadingOnPressed: ()=> Get.off(()=> const ProfileScreen()),
        title: Text('Re-Authenticate User', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///headings
          // Text(
          //   'Use real name for easy verification. This will appear on several pages.',
          //   style: Theme.of(context).textTheme.labelMedium,
          // ),
          // const SizedBox(height: TSizes.spaceBtwSections,),

          // ///text field and button
          
          Form(
           key: controller.reAuthFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon:  Icon(Iconsax.direct_right)
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                Obx(
                  () => TextFormField(
                                controller: controller.verifyPassword,
                                validator: (value) => TValidator.validateEmptyText('Password', value),
                                obscureText: controller.hidePassword.value,
                                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                    ),
                                ),
                              ),
                ),
              ],
            )
            
          ),
          const SizedBox(height: TSizes.spaceBtwSections,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> controller.reAutheticateEmailAndPasswordUser(), child: const Text('Verify')),
          )
          
          ],
        ),
        ),
    );
  }
}