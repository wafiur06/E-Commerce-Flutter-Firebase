import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_pages.dart';

class WlcomeScreen extends StatelessWidget {
  const WlcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Get Started",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlutterSocialButton(
                  onTap: () {},
                  buttonType: ButtonType.facebook,
                ),
                const Gap(10),
                FlutterSocialButton(
                  onTap: () {},
                  buttonType: ButtonType.twitter,
                ),
                const Gap(10),
                FlutterSocialButton(
                  onTap: () {},
                  buttonType: ButtonType.google,
                ),
              ],
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: ()=> context.pushNamed(Routes.LOGIN_ROUTE),
                    child: Text(
                      'Signin',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),


              InkWell(
                onTap: ()=> context.pushNamed(Routes.REGISTER_ROUTE),
                child: Container(
                  height: 80.h,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  child: Center(
                    child: Text(
                      'Create An Account',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
