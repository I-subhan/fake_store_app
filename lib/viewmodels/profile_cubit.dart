import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class ProfileCubit extends Cubit<UserModel?> {
  ProfileCubit(this.repo) : super(null);

  final UserRepository repo;

  Future<void> load(int id) async {
    final user = await repo.getUser(id);
    emit(user);
  }
}
