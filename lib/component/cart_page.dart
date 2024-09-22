import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_google/component/cart_bloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.selectedCategories.isEmpty) {
            return Center(child: Text('No items in cart'));
          } else {
            return ListView.builder(
              itemCount: state.selectedCategories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.selectedCategories[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
