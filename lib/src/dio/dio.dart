import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

const baseUrl = 'http://45.10.110.181:8080/api/v1';
Dio get getDio => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.jsonContentType,
      ),
    );
// (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
//     (HttpClient client) {
//   client.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => true;
//   return client;
// };

Future<Dio> getApiClient() async {
  final dio = getDio;
  final String? token =
      Hive.box('tokens').get('data', defaultValue: {})['accessToken'];
  final String? refreshtoken =
      Hive.box('tokens').get('data', defaultValue: {})['refreshToken'];
  dio.interceptors.clear();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        if (token != null && token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          try {
            await dio.post('$baseUrl/auth/login/refresh',
                data: {"refreshToken": refreshtoken}).then(
              (value) async {
                if (value.statusCode == 200 || value.statusCode == 201) {
                  await Hive.box('tokens').put('data', value.data);
                  print('access token ${value.data['accessToken']}');
                  print("refresh token ${value.data['refreshToken']}");
                  e.requestOptions.headers["Authorization"] =
                      "Bearer ${value.data['accessToken']}";
                  final opts = Options(
                      method: e.requestOptions.method,
                      headers: e.requestOptions.headers);
                  final cloneReq = await dio.request(e.requestOptions.path,
                      options: opts,
                      data: e.requestOptions.data,
                      queryParameters: e.requestOptions.queryParameters);

                  return handler.resolve(cloneReq);
                }
              },
            );
          } catch (e) {
            print(e);
          }
        }
        return handler.next(e);
      },
    ),
  );
  return dio;
}
