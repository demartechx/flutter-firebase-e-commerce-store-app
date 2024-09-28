import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/login_sign_up/form_divider.dart';
import 'package:t_store/common/widgets/login_sign_up/social_buttons.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              TTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            //form
            const TSignupForm(),
  
            //Divider
          TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
    
          //social button
          const TSocialButtons(),
          ],
        ),
      )),
    );
  }
}

