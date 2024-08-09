import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/common/my_snackbar.dart';
import '../../../features/auth/domain/usecases/auth_usecase.dart';
import '../../../features/home/presentation/presentation/state/current_user_state.dart';


final profileViewModelProvider = StateNotifierProvider<ProfileViewModel,CurrentUserState>(
        (ref) {
      return ProfileViewModel(authUseCase: ref.read(authUseCaseProvider));
    }
);

class ProfileViewModel extends StateNotifier<CurrentUserState>{
  ProfileViewModel({required this.authUseCase}) : super(CurrentUserState.initial()){
    getCurrentUser();
  }

  final AuthUseCase authUseCase;

  getCurrentUser() {
    state = state.copyWith(isLoading: true);
    authUseCase.getCurrentUser().then((data) {
      data.fold(
            (failure) {
          state = state.copyWith(isLoading: false);
          showMySnackBar(message: failure.error, color: Colors.red);
        },
            (user) {
          state =
              state.copyWith(isLoading: false, authEntity: user);
        },
      );
    });
  }
}