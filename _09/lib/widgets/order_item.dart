import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  final ord.OrderItem orderItem;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.orderItem.products.length * 20 + 10, 100),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (bContext, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.orderItem.products[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.orderItem.products[index].quantity}x \$${widget.orderItem.products[index].price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
