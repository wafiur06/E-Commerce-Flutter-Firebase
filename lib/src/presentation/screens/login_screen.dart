import 'package:bloc_app/src/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../blocs/authentication/remember_switch_cubit.dart';
import '../../routes/route_pages.dart';
import '../widgets/widgets.dart';
import '../../blocs/blocs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Values.SIGN_IN_BUTTON_TEXT,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(50),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state){
                if(state is LoginSuccess) {
                  context.goNamed(Routes.HOME_ROUTE);
                }
                if(state is LoginFailed){
                  Fluttertoast.showToast(msg: state.message);
                }
              },
                  builder: (context, state) {
                    if (state is LoginInitial) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: state.emailController,
                              decoration: InputDecoration(
                                label: Text('Email'),
                                labelStyle: theme.textTheme.titleMedium
                                    ?.copyWith(
                                      color: theme.colorScheme.outlineVariant,
                                    ),
                              ),
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Email is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const Gap(10),
                            TextFormField(
                              obscureText: true,
                              controller: state.passwordController,
                              decoration: InputDecoration(
                                label: Text('Password'),
                                labelStyle: theme.textTheme.titleMedium
                                    ?.copyWith(
                                      color: theme.colorScheme.outlineVariant,
                                    ),
                              ),
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'Password is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Remember Me', style: theme.textTheme.labelMedium),
                BlocBuilder<RememberSwitchCubit, RememberSwitchState>(
                  builder: (context, state) {
                    return Switch(
                      value: state is SwitchChanged ? state.value : true,
                      onChanged: (value) => context
                          .read<RememberSwitchCubit>()
                          .switchToggle(value),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed(Routes.REGISTER_ROUTE),
                child: Text(
                  Values.SIGN_UP_BUTTON_TEXT,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return FullWidthButton(
                buttonText: Values.SIGN_IN_BUTTON_TEXT,
                buttonChild: state is LoginLoading
                    ? LoadingAnimationWidget.discreteCircle(
                        color: theme.colorScheme.onPrimary,
                        size: 35.w,
                      )
                    : null,
                onTap: () {
                  if (state is LoginInitial) {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(
                        RequestEmailLogin(
                          email: state.emailController.text,
                          password: state.passwordController.text,
                          isRememberMe: RememberSwitchCubit.isRememberMe,
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
