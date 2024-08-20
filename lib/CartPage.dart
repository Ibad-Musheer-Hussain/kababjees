// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            'lib/assets/background3.jpg', // Replace with your image asset path
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
                            return Stack(children: [
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: GlassmorphicContainer(
                                    height: 270,
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    borderRadius: 12,
                                    blur: 8,
                                    alignment: Alignment.bottomCenter,
                                    border: 1,
                                    linearGradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFffffff).withAlpha(30),
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
                                    child: Row(children: [
                                      Container(
                                        width: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 4,
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
                                                            Provider.of<CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .decrement(
                                                                    item);
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
                                                            Provider.of<CartProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .increment(
                                                                    item);
                                                          },
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Consumer<CartProvider>(
                                                builder: (context, cartProvider,
                                                    child) {
                                                  int itemPrice = int.parse(
                                                          quantitycontroller
                                                              .text) *
                                                      item.quantity;
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'Item Total: ${cartProvider.itemPrice(item)}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )),
                              Positioned(
                                right: 10,
                                top: 60,
                                child: Image.network(
                                  item.titleimage,
                                  cacheHeight: 170,
                                  cacheWidth: 140,
                                ),
                              ),
                              Positioned(
                                  top: 20,
                                  right: 35,
                                  child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white54,
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          cartProvider.removeItem(
                                              item.id, item);
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.red,
                                        )),
                                  ))
                            ]);
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<CartProvider>(
                            builder: (context, cartProvider, child) {
                              return Text(
                                'Total Price: ${cartProvider.totalPrice}',
                                style: TextStyle(color: Colors.white),
                              );
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            onPressed: () {},
                            label: Text("Checkout"),
                            icon: Icon(Icons.credit_card),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
