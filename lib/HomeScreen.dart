// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kababjees/Cuisines.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:kababjees/Special.dart';
import 'package:kababjees/itemCard.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;
import 'package:kababjees/CategoryList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Items> ItemList = [
    Items(
        id: 3,
        name: 'Masala Fries',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Plain Fries',
        price: 399,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e',
        ingredient: ["Buns", "Beef"]),
  ];

  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;
  List<dynamic> AllIDS = [];
  int index = 0;

  final List<String> _banners = [
    'lib/assets/banner1.jpg',
    'lib/assets/banner1.jpg',
    'lib/assets/banner1.jpg',
  ];

  int selectedIndex = 0;

  Color _color = Colors.blue;

  void _changeColor(int selectedIndex) {
    print(selectedIndex);
    Color newColor = Colors.grey;
    if (selectedIndex == 0) {
      newColor = Colors.yellow;
    } else if (selectedIndex == 1) {
      newColor = Colors.red;
    } else {
      newColor = Colors.black;
    }

    setState(() {
      _color = newColor;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchIDS();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _banners.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> fetchData(List<dynamic> ids) async {
    try {
      for (var id in ids) {
        final response = await http
            .get(Uri.parse('http://192.168.18.100:8080/api/items/$id'));
        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          print('Data for ID $id: $data');
          Items item = Items.fromJson(data);
          setState(() {
            ItemList.add(item);
            print(ItemList);
          });
        } else {
          print(
              'Failed to load data for ID $id. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchIDS() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.18.100:8080/api/items/ids'));
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 300) {
        AllIDS = json.decode(response.body);
        print(AllIDS);
        fetchData(AllIDS);
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
    print("all fetched successfully");
  }

  List<Type> Types = [
    Type(name: "burger", icon: "lib/assets/hamburger.png", color: Colors.amber),
    Type(name: "Burrito", icon: "lib/assets/burrito.png", color: Colors.red),
    Type(name: "Drinks", icon: "lib/assets/drinks.png", color: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          title: Icon(
            Icons.menu,
            color: Colors.transparent,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'lib/assets/background3.jpg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black
                  .withOpacity(0), // Transparent color to apply blur effect
            ),
          ),
          Container(
            decoration: BoxDecoration(
                //color: Color.fromARGB(245, 2, 7, 22)
                //color: Colors.white
                //gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,stops: [0.3,0.8,0.9],
                //colors: [Color.fromARGB(235, 192, 12, 12),Color.fromARGB(255, 255, 101, 0),Color.fromARGB(255, 255, 138, 8)])
                ),
            child: ListView(children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "What's New",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withAlpha(240)),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 150.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _banners.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        _banners[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Our Mainstay Menu",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withAlpha(240)),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 115.0),
                        child: GlassmorphicContainer(
                          height: 350,
                          width: 175,
                          borderRadius: 12,
                          blur: 8,
                          alignment: Alignment.bottomCenter,
                          border: 1,
                          linearGradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0x020616).withAlpha(40),
                                Color(0x020616).withAlpha(65),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Combo Burger              ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '900',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -4,
                        right: 5,
                        child: Container(
                          width: 35,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white70,
                              )),
                        ),
                      ),
                      Image.asset(
                        "lib/assets/HeartAttack.png",
                        width: 180,
                        height: 370,
                        fit: BoxFit.fitHeight,
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          if (frame != null) {
                            return child;
                          } else {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ]),
                    Column(
                      children: [
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GlassmorphicContainer(
                              height: 200,
                              width: 160,
                              borderRadius: 12,
                              blur: 8,
                              alignment: Alignment.bottomCenter,
                              border: 1,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0x020616).withAlpha(40),
                                    Color(0x020616).withAlpha(65),
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
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Fries                       ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '900',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white70,
                                  )),
                            ),
                          ),
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                            width: 160,
                            height: 160,
                            cacheHeight: 160,
                            cacheWidth: 160,
                            frameBuilder: (BuildContext context, Widget child,
                                int? frame, bool wasSynchronouslyLoaded) {
                              if (frame != null) {
                                return child;
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                );
                              }
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return child;
                              }
                            },
                          ),
                        ]),
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GlassmorphicContainer(
                              height: 200,
                              width: 160,
                              borderRadius: 12,
                              blur: 8,
                              alignment: Alignment.bottomCenter,
                              border: 1,
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0x020616).withAlpha(40),
                                    Color(0x020616).withAlpha(65),
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
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Chips                       ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '900',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white70,
                                  )),
                            ),
                          ),
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                            width: 160,
                            height: 160,
                            cacheHeight: 160,
                            cacheWidth: 160,
                            frameBuilder: (BuildContext context, Widget child,
                                int? frame, bool wasSynchronouslyLoaded) {
                              if (frame != null) {
                                return child;
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                );
                              }
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return child;
                              }
                            },
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Today's Specials",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withAlpha(240)),
                  )),
              SizedBox(
                height: 260,
                width: 140,
                child: ListView.builder(
                  itemCount: ItemList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = ItemList[index];
                    return ItemCard(item: item);
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Explore Cuisines",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withAlpha(240)),
                  )),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                        Cuisines(
                          item: ItemList.first,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
            ]),
          ),
          Positioned(
              bottom: 16,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18)),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.home,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => Specials()),
                            );
                          },
                          icon: Icon(Icons.local_offer)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.location_on)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.person))
                    ],
                  ),
                ),
              ))
        ]),
        endDrawer: Customdrawer());
  }
}

class Items {
  final int id;
  final String name;
  final int price;
  int quantity;
  final String description;
  final Category category;
  final List<String> ingredient;
  final String titleimage;

  Items({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.titleimage,
    required this.ingredient,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: 1, //json['quantity'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      titleimage: json['titleImage'],
      ingredient: List<String>.from(json['ingredients']),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({required this.id, required this.description, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'], description: json['description'], name: json['name']);
  }
}
