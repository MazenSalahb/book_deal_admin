import 'dart:developer';

import 'package:book_deal_admin/models/subscription_model.dart';
import 'package:book_deal_admin/services/base_url.dart';
import 'package:dio/dio.dart';

class SubscriptionService {
  final dio = Dio();

  Future<List<SubscriptionModel>> fetchSubscriptions() async {
    try {
      final response = await dio.get('$baseUrl/subscription');

      if (response.statusCode == 200) {
        final List<SubscriptionModel> subscriptions = [];
        final data = response.data;

        for (var item in data) {
          final subscription = SubscriptionModel.fromJson(item);
          subscriptions.add(subscription);
        }

        return subscriptions;
      } else {
        log(response.data.toString());
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> cancelSubscriptionSubscription(
      {required int id, required int bookId}) async {
    try {
      final response = await dio.delete('$baseUrl/subscription/$id', data: {
        'book_id': bookId,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        log(response.data.toString());
        return false;
      }
    } on DioException catch (e) {
      log(e.message.toString());
      return false;
    }
  }
}
