import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order.dart';

import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  Future<void> _getOrders(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: AppDrawer(),
      /*body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.ItemsCount,
              itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
            ),*/
      body: RefreshIndicator(
        onRefresh: () => _getOrders(context),
        child: FutureBuilder(
            // Trabalhar com requisições assincronas
            future: _getOrders(context),
            builder: (ctx, snapshot) {
              // snapshot -> Status da conexão
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                return Center(child: Text('Ocorreu um erro!'));
              } else {
                return Consumer<OrderList>(
                  builder: (ctx, orders, child) => ListView.builder(
                    itemCount: orders.ItemsCount,
                    itemBuilder: (ctx, i) =>
                        OrderWidget(order: orders.items[i]),
                  ),
                );
              }
            }),
      ),
    );
  }
}
