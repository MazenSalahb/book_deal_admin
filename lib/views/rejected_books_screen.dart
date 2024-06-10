// ignore_for_file: use_build_context_synchronously

import 'package:book_deal_admin/models/book_model.dart';
import 'package:book_deal_admin/services/book_service.dart';
import 'package:flutter/material.dart';

class RejectedBooksScreen extends StatefulWidget {
  const RejectedBooksScreen({super.key});

  @override
  State<RejectedBooksScreen> createState() => _RejectedBooksScreenState();
}

class _RejectedBooksScreenState extends State<RejectedBooksScreen> {
  Future<List<BookModel>>? future;

  void getPendingBooks() {
    future = BookService().getRejectedBooks();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPendingBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rejected Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List<BookModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ManageBookWidget(
                      book: snapshot.data![index],
                      getPendingBooks: getPendingBooks,
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data found'),
                );
              }
            } else {
              return const Center(
                child: Text('No data found'),
              );
            }
          },
        ),
      ),
    );
  }
}

class ManageBookWidget extends StatelessWidget {
  const ManageBookWidget({
    super.key,
    required this.book,
    required this.getPendingBooks,
  });
  final BookModel book;
  final VoidCallback getPendingBooks;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.image!,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'availability: ${book.availability}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.author!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Publisher: ${book.user!.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Approve book
                    bool isApproved =
                        await BookService().approveBook(id: book.id!);
                    if (isApproved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Book approved successfully'),
                        ),
                      );
                      getPendingBooks();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to approve book'),
                        ),
                      );
                    }
                  },
                  child: const Text('Approve'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    bool isDeleted =
                        await BookService().deleteBook(id: book.id!);
                    if (isDeleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Book deleted successfully'),
                        ),
                      );
                      getPendingBooks();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to delete book'),
                        ),
                      );
                    }
                  },
                  child: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
