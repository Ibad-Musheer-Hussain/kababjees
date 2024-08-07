import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kababjees/CustomDrawer.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:http/http.dart' as http;

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
        name: 'Beef',
        price: 499,
        quantity: 3,
        description: 'Beef Burger',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage:
            'https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Ad%20Pics%2F2024-07-23%2006%3A30%3A28.149645_0.png?alt=media&token=906df468-7080-4181-a8df-973faa1813b7',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ), // Custom icon to open endDrawer
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
        body: Stack(fit: StackFit.expand, children: [
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
                        fontSize: 24, color: Colors.white.withAlpha(240)),
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
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Our Mainstay Menu",
                    style: TextStyle(
                        fontSize: 24, color: Colors.white.withAlpha(240)),
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 85.0),
                        child: GlassmorphicContainer(
                          height: 370,
                          width: 175,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 280.0, right: 10),
                                  child: Text(
                                    "Combo Burger",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    '900',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 410.0, left: 145),
                        child: Container(
                          width: 40,
                          height: 60,
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
                              icon: Icon(Icons.shopping_cart)),
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
                        /*loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Return the image if loading is complete
                        } else {
                          return child; // Return the image with loading progress if it's still loading
                        }
                      }*/
                      ),
                    ]),
                    Column(
                      children: [
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: GlassmorphicContainer(
                              height: 200,
                              width: 180,
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 120.0, right: 100),
                                      child: Text(
                                        "Top 1",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        '740',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 175.0, left: 145),
                            child: Container(
                              width: 40,
                              height: 60,
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
                                  icon: Icon(Icons.shopping_cart)),
                            ),
                          ),
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                            width: 180,
                            height: 170,
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
                              width: 180,
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 120.0, right: 100),
                                      child: Text(
                                        "Top 2",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Text(
                                        '900',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 175.0, left: 145),
                            child: Container(
                              width: 40,
                              height: 60,
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
                                  icon: Icon(Icons.shopping_cart)),
                            ),
                          ),
                          Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                            width: 180,
                            height: 170,
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
                        fontSize: 24, color: Colors.white.withAlpha(240)),
                  )),
              Container(
                height: 320,
                width: 300,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: ItemList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = ItemList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/itemPage',
                                arguments: {'item': item});
                          },
                          child: Stack(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 134.0, right: 50),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          '${item.price}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 208.0, left: 175),
                              child: Container(
                                width: 40,
                                height: 60,
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
                                    onPressed: () {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .addItem(item);
                                      print("added");
                                    },
                                    icon: Icon(Icons.shopping_cart)),
                              ),
                            ),
                            Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                              width: 200,
                              height: 170,
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
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return child;
                                }
                              },
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Explore Menu",
                    style: TextStyle(
                        fontSize: 24, color: Colors.white.withAlpha(240)),
                  )),
              Center(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: GlassmorphicContainer(
                      height: 220,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 80.0, right: 200),
                              child: Text(
                                "Carte & Combos",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 8),
                              child: Text(
                                '1200.0',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200.0, top: 55),
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/biddy-45c49.appspot.com/o/Layer%201.png?alt=media&token=0c337285-c71c-415d-a223-190e6705a25e",
                      width: 200,
                      height: 170,
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
                          return child; // Return the image if loading is complete
                        } else {
                          return child; // Return the image with loading progress if it's still loading
                        }
                      },
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 30,
              )
            ]),
          ),
        ]),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black87,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(color: Colors.white),
            unselectedLabelStyle: TextStyle(color: Colors.white),
            currentIndex: index,
            onTap: (index) => (), // Set background color
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: "Create"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                  label: "Chats"),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: "History",
              ),
            ],
          ),
        ),
        endDrawer: Customdrawer());
  }
}

class Items {
  final int id;
  final String name;
  final double price;
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
