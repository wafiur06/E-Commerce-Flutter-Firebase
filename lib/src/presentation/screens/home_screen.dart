import 'package:bloc_app/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/authentication/login_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LogOutSuccess) {
                context.goNamed(Routes.WELCOME_ROUTE);
              }
              if (state is LogOutFailed) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: IconButton(
              onPressed: () => context.read<LoginBloc>().add(RequestSignOut()),
              icon: Icon(
                Icons.logout_rounded,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Hello! Bloc'),
            titleTextStyle: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            subtitle: Text('Welcome to Laza'),
            subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
