import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';

class Cuisines extends StatelessWidget {
  final dynamic item;

  const Cuisines({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/itemPage', arguments: {'item': item});
        print("tapped");
      },
      child: Container(
        height: 120,
        width: 110,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55.0,
                left: 10,
              ),
              child: GlassmorphicContainer(
                height: 100,
                width: 110,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Starters",
                      //item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.network(
                item.titleimage,
                width: 220,
                height: 170,
                cacheHeight: 70,
                cacheWidth: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
