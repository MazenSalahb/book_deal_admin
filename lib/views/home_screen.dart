import 'package:book_deal_admin/services/book_service.dart';
import 'package:book_deal_admin/services/users_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // welcome message
              const Text(
                'Welcome Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // statistics
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 22),
                child: StatisticsWidget(),
              ),
              // admin actions
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Manage Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle navigation
                          Navigator.of(context).pushNamed('/pending-books');
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.library_books),
                            SizedBox(height: 8),
                            Text('Pending Books'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle navigation
                          Navigator.of(context).pushNamed('/manage-books');
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book),
                            SizedBox(height: 8),
                            Text('Approved Books'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle navigation
                          Navigator.of(context).pushNamed('/rejected-books');
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.close),
                            SizedBox(height: 8),
                            Text('Rejected Books'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle navigation
                          Navigator.of(context).pushNamed('/subscriptions');
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payment),
                            SizedBox(height: 8),
                            Text('Subscriptions'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150,
          height: 100,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Books',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<int>(
                  future: BookService().booksCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    } else {
                      return const Text('No data found');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 150,
          height: 100,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total users',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<int>(
                  future: UsersService().usersCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      );
                    } else {
                      return const Text('No data found');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
