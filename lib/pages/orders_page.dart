import 'package:flutter/material.dart';
import 'package:newapp/widgets/app_drawer.dart';
import 'package:newapp/widgets/order.dart';
import 'package:provider/provider.dart';

import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> refreshOrders(BuildContext context) {
      return Provider.of<OrderList>(
        context,
        listen: false,
      ).loadOrders();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(
          context,
          listen: false,
        ).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(
              child: Text('Ocorreu um erro!'),
            );
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => RefreshIndicator(
                onRefresh: () => refreshOrders(context),
                child: ListView.builder(
                  itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
                  itemCount: orders.itemsCount,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
