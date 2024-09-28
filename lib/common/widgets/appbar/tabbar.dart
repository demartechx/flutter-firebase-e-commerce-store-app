import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TTapBar extends StatelessWidget implements PreferredSizeWidget {
  const TTapBar(
      {super.key,
      // this.title,
      // this.showBackArrow = false,
      // this.leadingIcon,
      required this.tabs,
 ///     this.leadingOnPressed
 });

  // final Widget? title;
  // final bool showBackArrow;
  // final IconData? leadingIcon;
  final List<Widget> tabs;
  //final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      color: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,

      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: TabBar(
          isScrollable: true,
          indicatorColor: TColors.primary,
          labelColor: dark
              ? TColors.white
              : TColors.black,
          tabs: tabs,
          unselectedLabelColor: TColors.darkGrey,
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
