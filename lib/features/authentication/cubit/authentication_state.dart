part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final String message;

  AuthenticationSuccess({required this.message});
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  AuthenticationFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
