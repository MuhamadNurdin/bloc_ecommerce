import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obsecureText;

  const MyTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: controller,
                obscureText: obsecureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail), 
                   labelText: 'Username',
                   labelStyle: const TextStyle(color: Colors.green), 
                   border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white)
                  ),
                    focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey[500])
                ),
              ),
            );

  }
}