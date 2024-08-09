// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/background.jpeg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black
                  .withOpacity(0), // Transparent color to apply blur effect
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  child: Text(
                    "Cart Page",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final cart = cartProvider.cart.items;
                    return Container(
                      height: MediaQuery.of(context).size.height - 240,
                      child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            final item = cart[index];
                            final quantitycontroller = TextEditingController();
                            quantitycontroller.text = item.quantity.toString();
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GlassmorphicContainer(
                                height: 270,
                                width: 165,
                                borderRadius: 12,
                                blur: 0,
                                alignment: Alignment.bottomCenter,
                                border: 1,
                                linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0x020616).withAlpha(40),
                                      Color(0xFFffffff).withAlpha(75),
                                    ],
                                    stops: [
                                      0.1,
                                      0.5,
                                    ]),
                                borderGradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      Color(0xFF4579C5).withAlpha(10),
                                      Color(0xFFFFFFF).withAlpha(20),
                                      Color(0xFFF75035).withAlpha(20),
                                    ],
                                    stops: [
                                      0.6,
                                      0.95,
                                      1
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 28),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                item.description,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis, // Truncate with ellipsis
                                                maxLines:
                                                    6, // Ensure text doesn't wrap to multiple lines
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          int temp = int.parse(
                                                              quantitycontroller
                                                                  .text
                                                                  .toString());
                                                          temp--;
                                                          quantitycontroller
                                                                  .text =
                                                              temp.toString();
                                                        },
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        )),
                                                    Container(
                                                      width: 50,
                                                      child: TextField(
                                                        controller:
                                                            quantitycontroller,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly, // Allow only digits
                                                          LengthLimitingTextInputFormatter(
                                                              2), // Limit to two digits
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          border: InputBorder
                                                              .none, // Transparent border
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide: BorderSide
                                                                .none, // Transparent border
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            borderSide: BorderSide
                                                                .none, // Transparent border
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          int temp = int.parse(
                                                              quantitycontroller
                                                                  .text
                                                                  .toString());
                                                          temp++;
                                                          quantitycontroller
                                                                  .text =
                                                              temp.toString();
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: Image.network(item.titleimage),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 30, right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(14)),
                    height: 60,
                    child: Row(
                      children: [
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            return Text(
                              'Total Price: ${cartProvider.totalPrice}',
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
