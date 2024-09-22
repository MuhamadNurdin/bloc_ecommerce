import 'package:flutter/material.dart';
import 'package:login_google/model/cart_model.dart'; // Your CartItem model

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function onClearCart;

  CartPage({required this.cartItems, required this.onClearCart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _increaseQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
    });
  }

  void _decreaseQuantity(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        widget.cartItems.remove(cartItem);
      }
    });
  }

  void _removeItem(CartItem cartItem) {
    setState(() {
      widget.cartItems.remove(cartItem);
    });
  }

  double getTotalPrice() {
    return widget.cartItems.fold(0, (total, item) => total + (item.product['price'] * item.quantity));
  }

  int getTotalItemCount() {
    return widget.cartItems.fold(0, (total, item) => total + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onClearCart(); // Clear cart when pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems[index];
                return ListTile(
                  leading: Image.network(cartItem.product['image'], width: 50),
                  title: Text(cartItem.product['title']),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(cartItem),
                          ),
                          Text('Quantity: ${cartItem.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _increaseQuantity(cartItem),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeItem(cartItem),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ${getTotalItemCount()} Items',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'USD ${getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle checkout action
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Proceed to Checkout'),
                  SizedBox(width: 8), // Add some space between text and icon
                  Icon(Icons.arrow_right_alt_sharp),
                ],
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Button color
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
          ),
        ],
      ),
    );
  }
}
