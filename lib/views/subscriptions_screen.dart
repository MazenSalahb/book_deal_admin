// ignore_for_file: use_build_context_synchronously

import 'package:book_deal_admin/models/subscription_model.dart';
import 'package:book_deal_admin/services/subscription_service.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Subscriptions'),
        ),
        body: FutureBuilder<List<SubscriptionModel>>(
          future: SubscriptionService().fetchSubscriptions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }

            final List<SubscriptionModel> subscriptions = snapshot.data!;

            return ListView.builder(
              itemCount: subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = subscriptions[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              subscription.book!.image!,
                              width: MediaQuery.of(context).size.width * 0.22,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  'book: ${subscription.book!.title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Price: ${subscription.price}EGP',
                                style: const TextStyle(color: Colors.green),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Duration: ${subscription.endDate}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Builder(
                                builder: (context) {
                                  if (subscription.status == 'active') {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        final bool result =
                                            await SubscriptionService()
                                                .cancelSubscriptionSubscription(
                                                    id: subscription.id!,
                                                    bookId:
                                                        subscription.book!.id!);

                                        if (result) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Subscription canceled'),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('An error occurred'),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Cancel Subscription'),
                                    );
                                  } else {
                                    return const Text(
                                      'Subscription Canceled',
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
