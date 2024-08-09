import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(225, 14, 14, 14),
      width: MediaQuery.of(context).size.width * 0.5,
      child: GlassmorphicContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 100,
        borderRadius: 12,
        blur: 0,
        alignment: Alignment.bottomCenter,
        border: 1,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x020616).withAlpha(70),
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
              Color(0xFF4579C5).withAlpha(01),
              Color(0xFFFFFFF).withAlpha(20),
              Color(0xFFF75035).withAlpha(20),
            ],
            stops: [
              0.6,
              0.95,
              1
            ]),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cart = cartProvider.cart.items;
                return Container(
                  height: 700,
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 150,
                          child: Stack(children: [
                            Center(
                              child: Image.network(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  fit: BoxFit.fitWidth,
                                  "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 100.0, left: 100),
                              child: Center(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white54,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      print("Removing item id: ${item.id}");
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .removeItem(item.id, item);
                                    },
                                    icon: Icon(Icons.close),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 100.0, right: 100),
                              child: Center(
                                child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white54,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${item.quantity}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Text(
                  'Total Price: ${cartProvider.totalPrice}',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
            Center(
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cartPage');
                  },
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
