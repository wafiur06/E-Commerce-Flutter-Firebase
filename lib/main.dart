import 'package:bloc_app/app.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_app/src/blocs/blocs.dart';
import 'package:bloc_app/src/data/preference/local_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = BlocAppObserver();
  await LocalPreferences().init();
  runApp(const BlocEcommerceApp());
}