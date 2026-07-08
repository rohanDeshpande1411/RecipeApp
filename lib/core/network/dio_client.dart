import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';

import 'api_constant.dart';

class DioClient {
  late Dio dio;

  final SecureStorage storage;

  Future<bool> refreshToken() async {
    String? refresh = await storage.getRefreshToken();

    if (refresh == null) {
      return false;
    }

    try {
      Response response =
          await dio.post(ApiConstant.refresh, data: {"refreshToken": refresh});

      String newAccess = response.data['accessToken'];

      String newRefresh = response.data['refreshToken'];

      await storage.saveToken(accessToken: newAccess, refreshToken: newRefresh);

      return true;
    } catch (e) {
      return false;
    }
  }

  DioClient(this.storage) {
    dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? token = await storage.getAccessToken();

      if (token != null) {
        options.headers["Authorization"] = 'Bearer $token';
      }

      handler.next(options);
    }, onError: (error, handler) async {
      if (error.response?.statusCode == 401) {
        bool refreshed = await refreshToken();

        if (refreshed) {
          final retryRequest = await dio.request(error.requestOptions.path,
              options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers),
              data: error.requestOptions.data);

          return handler.resolve(retryRequest);
        } else {
          await storage.clearToken();
        }
      }

      return handler.next(error);
    }));
  }
}
