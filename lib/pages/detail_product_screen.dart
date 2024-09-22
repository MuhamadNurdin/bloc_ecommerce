import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;
  final Function(dynamic) onAddToCart;

  ProductDetailScreen({required this.product, required this.onAddToCart});

  Widget buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(
          i < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      );
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product['image'], fit: BoxFit.cover),
              SizedBox(height: 16),
              // Price above the title
              Text(
                'USD ${product['price']}',
                style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Product title
              Text(
                product['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // Rating and reviews
              Row(
                children: [
                  buildStarRating(product['rating']['rate']),
                  const SizedBox(width: 8),
                  Text('${product['rating']['count']} reviews'),
                ],
              ),
              SizedBox(height: 8),
              // Description or additional details
              Text(
                product['description'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Add to Cart button
              SizedBox(
                width: double.infinity, // Full width
                child: ElevatedButton(
                  onPressed: () {
                    onAddToCart(product);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Border radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16), // Padding
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white), // Button text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
