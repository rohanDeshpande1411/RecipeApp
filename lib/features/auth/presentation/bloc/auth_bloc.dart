import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/auth_repository.dart';

import 'auth_event.dart';

import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_login);

    on<CheckAuthStatus>(_checkAuth);

    on<LogoutRequested>(_logout);
  }

  Future<void> _login(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await repository.login(event.username, event.password);

      emit(Authenticated(user.username));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _checkAuth(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    String? token = await repository.storage.getAccessToken();

    if (token != null) {
      emit(Authenticated("User"));
    } else {
      emit(UnAuthenticated());
    }
  }

  Future<void> _logout(LogoutRequested event, Emitter<AuthState> emit) async {
    await repository.logout();

    emit(UnAuthenticated());
  }
}
