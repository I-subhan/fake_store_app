import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class UserRepository {
  Future<UserModel> getUser(int id) async {
    final res = await DioClient.dio.get("${ApiConstants.users}/$id");
    return UserModel.fromJson(res.data);
  }
}
