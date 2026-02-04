import 'package:bloc_app/src/blocs/authentication/signup_bloc.dart';
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

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              "Sign Up",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            BlocConsumer<SignupBloc, SignupState>(
              listener: (context, state) {
                if(state is SignUpSuccess){
                  context.goNamed(Routes.HOME_ROUTE);
                }
                if(state is SignUpFailure){
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              builder: (context, state) {
                return BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state is SignupInitial) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: state.usernameController,
                              decoration: InputDecoration(
                                label: Text('UserName'),
                                labelStyle: theme.textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outlineVariant,
                                    ),
                              ),
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'UserName is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            TextFormField(
                              controller: state.emailController,
                              decoration: InputDecoration(
                                label: Text('Email'),
                                labelStyle: theme.textTheme.titleMedium
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outlineVariant,
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

                            TextFormField(
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
                            TextFormField(
                              controller: state.confirmPasswordController,
                              decoration: InputDecoration(
                                label: Text('Confirm Password'),
                                labelStyle: theme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: theme.colorScheme.outlineVariant,
                                ),
                              ),
                              validator: (value) {
                                if (value != state.passwordController.text || value == null) {
                                  return 'Password Does not Match';
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
                );
              },
            ),

            const Gap(20),
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

            const Gap(445),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return FullWidthButton(
                  buttonText: 'Sign Up',
                  buttonChild: state is SignUpLoading
                      ? LoadingAnimationWidget.discreteCircle(
                          color: theme.colorScheme.onPrimaryContainer,
                          size: 35.w,
                        )
                      : null,
                  onTap: () {
                    if (state is SignupInitial) {
                      if (formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(
                          RequestEmailSignUp(
                            username: state.usernameController.text,
                            email: state.emailController.text,
                            password: state.passwordController.text,
                            confirmPassword:
                                state.confirmPasswordController.text,
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
      ),
    );
  }
}
