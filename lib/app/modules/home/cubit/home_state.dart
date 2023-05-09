import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.regular() = HomeStateRegular;
  factory HomeState.loading() = HomeStateLoading;
  factory HomeState.empty() = HomeStateEmpty;
  factory HomeState.error() = HomeStateError;
  factory HomeState.unauthenticated() = HomeStateUnauthenticated;
}
