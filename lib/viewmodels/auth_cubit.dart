import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/utils/token_storage.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repo) : super(AuthInitial());

  final AuthRepository repo;

  Future<void> login(String user, String pass) async {
    try {
      emit(AuthLoading());

      final token = await repo.login(user, pass);

      await TokenStorage.saveToken(token);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure("Invalid username or password"));
    }
  }
}
