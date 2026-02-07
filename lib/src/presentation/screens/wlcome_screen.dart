import 'package:bloc_app/src/blocs/blocs.dart';
import 'package:bloc_app/src/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route_pages.dart';
import '../widgets/widgets.dart';

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
          BlocConsumer<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlutterSocialButton(
                      onTap: () =>
                          (context).read<LoginBloc>().add(RequestFacebookLogin()),
                      buttonType: ButtonType.facebook,
                    ),
                    const Gap(10),
                    FlutterSocialButton(
                      onTap: () =>
                          (context).read<LoginBloc>().add(RequestTwitterLogin()),
                      buttonType: ButtonType.twitter,
                    ),
                    const Gap(10),
                    FlutterSocialButton(
                      onTap: () =>
                          context.read<LoginBloc>().add(RequestGoogleLogin()),
                      buttonType: ButtonType.google,
                    ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state is LoginSuccess) {
                Fluttertoast.showToast(msg: 'Login Successful');
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.goNamed(Routes.HOME_ROUTE);
                });
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Column(
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
                onPressed: () => context.pushNamed(Routes.LOGIN_ROUTE),
                child: Text(
                  Values.SIGN_IN_BUTTON_TEXT,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
            ],
          ),
          FullWidthButton(
            buttonText: Values.CREATE_ACCOUNT_TEXT,
            onTap: () => context.pushNamed(Routes.REGISTER_ROUTE),
          ),
        ],
      ),
    );
  }
}
