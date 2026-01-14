import 'package:bloc_app/app.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_app/src/blocs/blocs.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = BlocAppObserver();
  runApp(const BlocEcommerceApp());
}