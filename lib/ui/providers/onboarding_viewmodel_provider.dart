import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todooo/states/on_boarding_state.dart';
import 'package:todooo/ui/providers/user_repository_provider.dart';
import 'package:todooo/viewmodels/onboarding_viewmodel.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, OnboardingState>((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  return OnboardingViewModel(userRepo, email: "", password: "", confirmPassword: "");
});