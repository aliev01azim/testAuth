import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void showInfo(context, GlobalKey key, text) async {
  final box = key.currentContext?.findRenderObject() as RenderBox;
  final offset = box.localToGlobal(Offset.zero);
  final entry = OverlayEntry(
    builder: (_) => Positioned(
      top: offset.dy + 70,
      right: 16,
      child: Material(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Text(text),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(entry);
  await Future.delayed(const Duration(seconds: 4));
  entry.remove();
}

Future<void> checkConnection(Dio dio) async {
  Future<Response> retry(
      RequestOptions requestOptions, String newAccess) async {
    final newheader = requestOptions.headers;
    newheader.update(
      'authorization',
      (value) => 'Bearer $newAccess',
      ifAbsent: () => 'Bearer $newAccess',
    );
    final options = Options(
      method: requestOptions.method,
      headers: newheader,
    );
    final reaponse = await dio.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);

    return reaponse;
  }

  Future<String?> refreshToken() async {
    var refreshToken = Hive.box('userBox').get('user')['refreshToken'];
    final response = await dio.get('/users/refresh/$refreshToken');
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final user = Hive.box('userBox').get('user');
      user['accessToken'] = response.data['accessToken'];
      user['refreshToken'] = response.data['refreshToken'];
      await Hive.box('userBox').put('user', user);
      return Hive.box('userBox').get('user')['accessToken'];
    } else {
      // refresh token is wrong
      // await Hive.box('userBox').clear();
      return null;
    }
  }

  try {
    if (!kIsWeb) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        dio.interceptors.add(
          QueuedInterceptorsWrapper(
            onResponse: (e, handler) async => handler.next(e),
            onRequest: (options, handler) async {
              final accessToken = Hive.box('userBox').get('user')?['access'];
              if (accessToken != null) {
                options.headers['authorization'] = 'Bearer $accessToken';
              }
              return handler.next(options);
            },
            onError: (DioException error, handler) async {
              if ((error.response?.statusCode == 401)) {
                final user = Hive.box('userBox').get('user', defaultValue: {});
                if (user['refreshToken'] != null) {
                  final res = await refreshToken();
                  if (res != null) {
                    final asd =
                        await retry(error.response!.requestOptions, res);

                    return handler.resolve(asd);
                  }
                }
              }

              return handler.next(error);
            },
          ),
        );
      }
    }
  } on SocketException catch (_) {
    return;
  }
}
