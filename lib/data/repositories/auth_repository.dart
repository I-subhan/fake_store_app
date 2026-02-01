import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  Future<String> login(String username, String password) async {
    final response = await DioClient.dio.post(
      ApiConstants.login,
      data: {
        "username": username,
        "password": password,
      },
    );

    return response.data["token"];
  }
}
