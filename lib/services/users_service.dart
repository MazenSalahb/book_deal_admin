import 'dart:developer';

import 'package:book_deal_admin/services/base_url.dart';
import 'package:dio/dio.dart';

class UsersService {
  final dio = Dio();

  Future<int> usersCount() async {
    try {
      final response = await dio.get(
        '$baseUrl/users/count',
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'keep-alive': 'timeout=5, max=1000',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 0;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}
