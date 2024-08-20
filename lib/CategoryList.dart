import 'package:flutter/material.dart';

class Type {
  final String name;
  final String icon;
  final Color color;

  Type({required this.name, required this.icon, required this.color});
}

class CategoryList extends StatefulWidget {
  final List<Type> types;
  final int selectedIndex;
  final Function onCategoryTap;

  CategoryList({
    required this.types,
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.types.length,
        itemBuilder: (BuildContext context, int index) {
          Type type = widget.types[index];
          return GestureDetector(
            onTap: () {
              widget.onCategoryTap(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.0, left: 4),
              decoration: BoxDecoration(
                  color: type.color, borderRadius: BorderRadius.circular(14)),
              height: 20,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset(type.icon),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
