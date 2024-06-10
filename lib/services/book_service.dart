import 'dart:developer';

import 'package:book_deal_admin/models/book_model.dart';
import 'package:book_deal_admin/services/base_url.dart';
import 'package:dio/dio.dart';

class BookService {
  final dio = Dio();

  Future<List<BookModel>> getPendingBooks() async {
    try {
      final response = await dio.get(
        '$baseUrl/books/pending',
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
        final List<BookModel> books = [];
        for (var item in response.data) {
          books.add(BookModel.fromJson(item));
        }
        return books;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<BookModel>> getRejectedBooks() async {
    try {
      final response = await dio.get(
        '$baseUrl/books/rejected',
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
        final List<BookModel> books = [];
        for (var item in response.data) {
          books.add(BookModel.fromJson(item));
        }
        return books;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<BookModel>> getApprovalBooks() async {
    try {
      final response = await dio.get(
        '$baseUrl/books/approval',
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
        final List<BookModel> books = [];
        for (var item in response.data) {
          books.add(BookModel.fromJson(item));
        }
        return books;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> approveBook({required int id}) async {
    try {
      final response = await dio.put(
        '$baseUrl/books/approve/$id',
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> rejectBook({required int id}) async {
    try {
      final response = await dio.put(
        '$baseUrl/books/reject/$id',
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteBook({required int id}) async {
    try {
      final response = await dio.delete(
        '$baseUrl/books/$id',
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
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<int> booksCount() async {
    try {
      final response = await dio.get(
        '$baseUrl/books/count',
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
