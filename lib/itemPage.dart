import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Itempage extends StatefulWidget {
  const Itempage({super.key});

  @override
  State<Itempage> createState() => _ItempageState();
}

class _ItempageState extends State<Itempage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  void _increment() {
    int currentValue = int.tryParse(_controller.text) ?? 0;

    if (currentValue < 99) {
      _controller.text = (currentValue + 1).toString();
    }
  }

  void _decrement() {
    int currentValue = int.tryParse(_controller.text) ?? 0;

    if (currentValue > 0) {
      _controller.text = (currentValue - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Items item = arguments['item'] as Items;
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/assets/background.jpeg',
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 32),
              child: GlassmorphicContainer(
                height: 210,
                width: 200,
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
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                SimpleShadow(
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e'),
                  opacity: 1,
                  color: Colors.black,
                  offset: Offset(2, 8),
                  sigma: 10,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  //"${item.name}",
                  "Masala Fries",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    "Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50, // Distance from the bottom
              left: 20, // Distance from the left
              right: 20, // Distance from the right
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _decrement();
                        },
                        icon: Icon(Icons.remove)),
                    Container(
                      width: 50,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Allow only digits
                          LengthLimitingTextInputFormatter(
                              2), // Limit to two digits
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _increment();
                        },
                        icon: Icon(Icons.add)),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .changequantity(
                                item, int.parse(_controller.text.toString()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart),
                              Text("Add to cart")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        endDrawer: Customdrawer());
  }
}
