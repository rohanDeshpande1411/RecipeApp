import 'package:dio/dio.dart';

import '../../../core/network/api_constant.dart';

import '../../../core/network/dio_client.dart';

import '../../../core/storage/secure_storage.dart';

import 'auth_model.dart';

class AuthRepository {
  final DioClient client;

  final SecureStorage storage;

  AuthRepository(this.client, this.storage);

  Future<AuthModel> login(String username, String password) async {
    try {
      Response response = await client.dio.post(ApiConstant.login,
          data: {"username": username, "password": password});

      AuthModel user = AuthModel.fromJson(response.data);

      await storage.saveToken(
          accessToken: user.accessToken, refreshToken: user.refreshToken);

      return user;
    } catch (e) {
      throw Exception("Invalid Login");
    }
  }

  Future<void> logout() async {
    await storage.clearToken();
  }
}
