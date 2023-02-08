import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist_app_flutter/features/authentication/repositories/auth_repositories.dart';
import 'package:todolist_app_flutter/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final AuthRepositories repository = locator.get<AuthRepositories>();

  void registerEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      emit(AuthenticationLoading());
      await repository.registerFirebase(context, email, password);
      emit(AuthenticationSuccess(message: "Register Success"));
    } on FirebaseException catch (e) {
      emit(AuthenticationFailed(message: e.message!));
    }
  }

  void signInEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      emit(AuthenticationLoading());
      await repository.loginFirebase(context, email, password);
      emit(AuthenticationSuccess(message: "Login Success"));
    } on FirebaseException catch (e) {
      emit(AuthenticationFailed(message: e.message!));
    }
  }

  void signInGoogle() async {
    try {
      emit(AuthenticationLoading());
      await repository.signInGoogle();
      emit(AuthenticationSuccess(message: "Login Success"));
    } on FirebaseException catch (e) {
      emit(AuthenticationFailed(message: e.message!));
    }
  }
}
