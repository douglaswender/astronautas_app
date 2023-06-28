import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState.regular() = ProfileStateRegular;
  factory ProfileState.loading() = ProfileStateLoading;
  factory ProfileState.empty() = ProfileStateEmpty;
  factory ProfileState.error() = ProfileStateError;
}
