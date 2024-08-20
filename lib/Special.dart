import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:kababjees/HomeScreen.dart';

class Specials extends StatefulWidget {
  @override
  _SpecialsState createState() => _SpecialsState();
}

class _SpecialsState extends State<Specials>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = -1;
  String centerText = "Masala Fries1";
  late Items selectedItem;

  List<Items> rotateList = [
    Items(
        id: 3,
        name: 'Masala Fries1',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/topdown.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries2',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/burger.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries3',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/Layer1.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries4',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/topdown.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries5',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/Layer1.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries6',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/burger.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries7',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/topdown.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries8',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/Layer1.png',
        ingredient: ["Buns", "Beef"]),
    Items(
        id: 3,
        name: 'Masala Fries9',
        price: 499,
        quantity: 1,
        description:
            'Savor our Masala Fries, coated in a spicy masala mix for an Indian-inspired flavor. Perfect as a snack, offering a delicious blend of spicy and herb-infused goodness.',
        category: Category(id: 1, description: "asd", name: "Burgers"),
        titleimage: 'lib/assets/topdown.png',
        ingredient: ["Buns", "Beef"]),
  ];

  @override
  void initState() {
    super.initState();
    selectedItem = rotateList[1];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/background3.jpg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Center(
              child: Stack(
            children: [
              Positioned(
                  left: MediaQuery.of(context).size.width - 120,
                  //right: 80,
                  child: Container(
                    width: 100,
                    child: Text(
                      "Today's Special",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Positioned(
                left: -MediaQuery.of(context).size.width / 1.4,
                top: -MediaQuery.of(context).size.height * 0.08,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.325,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(221, 17, 17, 17),
                        Color.fromARGB(221, 17, 17, 17),
                      ],
                      stops: [0.7, 0.8],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: Colors.transparent,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color(0xFF4579C5).withAlpha(10),
                          Color(0xFFFFFFF).withAlpha(20),
                          Color(0xFFF75035).withAlpha(20),
                        ],
                        stops: [0.6, 0.95, 1],
                      ),
                    ),
                  ),
                ),
              ),
              CircleList(
                origin: Offset(-MediaQuery.of(context).size.width, 0),
                outerRadius: MediaQuery.of(context).size.width / 1.09,
                innerRadius: MediaQuery.of(context).size.width / 2.4,
                childrenPadding: 10,
                centerWidget: Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/itemPage',
                          arguments: {'item': selectedItem});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          "  ${centerText}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                children: List.generate(rotateList.length, (index) {
                  bool isSelected = _selectedIndex == index;
                  Items rotateItem = rotateList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = isSelected ? -1 : index;
                        centerText = rotateItem.name;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: isSelected ? 170 : 130,
                      height: isSelected ? 170 : 130,
                      child: Image.asset(
                        rotateItem.titleimage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ],
          )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/HomeScreen',
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(221, 17, 17, 17),
              borderRadius: BorderRadius.circular(22)),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
