import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../data/repository/repository.dart';


part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<RequestGoogleLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await repository.signInWithGoogle();

        // FIX: Check if the user is null before emitting Success
        if (user != null) {
          debugPrint('User: ${user.displayName}');
          emit(LoginSuccess());
        } else {
          // If repository returned null, it means sign-in was canceled or failed
          emit(LoginFailed("Google Sign-In was unsuccessful or canceled."));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailed(e.toString()));
      }
    });


    on<RequestFacebookLogin>((event, emit) async {
      emit(LoginLoading());

      try {
        final user = await repository.signInWithFacebook();

        // FIX: Check if the user is null before emitting Success
        if (user != null) {
          debugPrint('User: ${user.displayName}');
          emit(LoginSuccess());
        } else {
          // If repository returned null, it means sign-in was canceled or failed
          emit(LoginFailed("Facebook Sign-In was unsuccessful or canceled."));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailed(e.toString()));
      }
    });


    on<RequestTwitterLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await repository.signInWithTwitter();
        debugPrint('User: ${user?.displayName}');
        if (user != null) {
          debugPrint('User: ${user.displayName}');
          emit(LoginSuccess());
        } else {
          emit(LoginFailed("Twitter Sign-In was unsuccessful or canceled."));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(LoginFailed(e.toString()));
      }
    });

    on<RequestEmailLogin>((event, emit) async{
      debugPrint("Email : ${event.email}, password: ${event.password}, rememberMe: ${event.isRememberMe}");
      try{
        await repository.signInWithEmail(event.email, event.password).then((value) => emit(LoginSuccess()));
      }catch(e){
        emit(LoginFailed(e.toString()));
      }
    });

    on<RequestSignOut>((event, emit) async {
      try{
        await repository.signoutUser().then((value) => emit(LogOutSuccess()));
      }catch(e){
        emit(LogOutFailed(message: e.toString()));
      }
    });
  }
}
