import 'package:book_deal_admin/views/main_screen.dart';
import 'package:book_deal_admin/views/manage_books_screen.dart';
import 'package:book_deal_admin/views/pending_books_screen.dart';
import 'package:book_deal_admin/views/rejected_books_screen.dart';
import 'package:book_deal_admin/views/subscriptions_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Deal Admin',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const MainScreen(),
        '/pending-books': (context) => const PendingBooksScreen(),
        '/manage-books': (context) => const ApprovedBooksScreen(),
        '/rejected-books': (context) => const RejectedBooksScreen(),
        '/subscriptions': (context) => const SubscriptionsScreen(),
      },
      initialRoute: '/',
    );
  }
}
