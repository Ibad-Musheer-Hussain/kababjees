import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final dynamic item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/itemPage', arguments: {'item': item});
        },
        child: Container(
          height: 200,
          width: 185,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 35.0,
                  left: 20,
                ),
                child: GlassmorphicContainer(
                  height: 200,
                  width: 145,
                  borderRadius: 12,
                  blur: 8,
                  alignment: Alignment.bottomCenter,
                  border: 1,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0x020616).withAlpha(40),
                      const Color(0x020616).withAlpha(65),
                    ],
                    stops: const [0.1, 0.5],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      const Color(0xFF4579C5).withAlpha(10),
                      const Color(0xFFFFFFF).withAlpha(20),
                      const Color(0xFFF75035).withAlpha(20),
                    ],
                    stops: const [0.6, 0.95, 1],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${item.name}           ',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${item.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -3,
                right: 20,
                child: Container(
                  width: 35,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addItem(item);
                      print("added");
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              Image.network(
                item.titleimage,
                width: 220,
                height: 170,
                cacheHeight: 150,
                cacheWidth: 160,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
