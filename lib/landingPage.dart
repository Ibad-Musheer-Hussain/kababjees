import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:kababjees/Special.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/background3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.white.withOpacity(0.0),
            ),
          ),
          Center(
              child: GlassmorphicContainer(
                  height: MediaQuery.of(context).size.height - 150,
                  width: MediaQuery.of(context).size.width - 50,
                  borderRadius: 12,
                  blur: 8,
                  alignment: Alignment.bottomCenter,
                  border: 1,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x020616).withAlpha(10),
                        Color(0x020616).withAlpha(30),
                      ],
                      stops: [
                        0.0,
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
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SimpleShadow(
                            child: Image.asset('lib/assets/images.png'),
                            opacity: 0.7,
                            color: Colors.black,
                            offset: Offset(2, 8),
                            sigma: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Text(
                            "Enhance your diet with a selection of flavorful recipes that provider both great nutrition and enjoyable taste, making each meal a pleasure",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(221, 17, 17, 17),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(50.0),
                          child: FloatingActionButton.extended(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => Specials()),
                              );
                            },
                            label: Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Spacer()
                      ])))
        ],
      ),
    );
  }
}
