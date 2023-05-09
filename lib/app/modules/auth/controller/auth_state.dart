import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.regular() = AuthStateRegular;
  factory AuthState.loading() = AuthStateLoading;
  factory AuthState.empty() = AuthStateEmpty;
  factory AuthState.error() = AuthStateError;
}
