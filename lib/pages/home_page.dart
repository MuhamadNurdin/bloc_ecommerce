import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_google/component/costum_rating_widget.dart';
import 'package:login_google/pages/cart_page.dart'; // Adjust this import
import 'package:login_google/pages/detail_product_screen.dart';
import 'package:login_google/pages/search_page.dart';
import 'package:login_google/services/api_service.dart';
import 'package:login_google/model/cart_model.dart'; // Assuming this is where CartItem is defined

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _products;
  List<CartItem> cartItems = []; // List of cart items
  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Electronics',
    'Men\'s Clothing',
    'Women\'s Clothing',
    'Jewelery',
  ];

  @override
  void initState() {
    super.initState();
    _products = _apiService.fetchProductsByCategory('electronics');
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _products = category == 'All'
          ? _apiService.fetchAllProducts()
          : _apiService.fetchProductsByCategory(category.toLowerCase());
    });
  }

  void _addToCart(dynamic product) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item.product['id'] == product['id'],
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        cartItems.add(CartItem(product: product, quantity: 1));
      }
    });
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigate to the profile screen
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'lib/images/shop_it.png',
          height: 90,
          width: 90,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(), // SearchPage
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: cartItems,
                    onClearCart: _clearCart,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signUserOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, ${user.email!}", style: const TextStyle(fontSize: 13)),
            const Text(
              "What are you looking for today?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (bool selected) {
                        _selectCategory(category);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                onAddToCart: _addToCart,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  product['image'],
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product['title'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$${product['price']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                     const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        RatingWidget(rating: product['rating']['rate']),
                                        const SizedBox(width: 8),
                                        Text('${product['rating']['count']} reviews'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
