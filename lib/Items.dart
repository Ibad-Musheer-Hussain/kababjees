class Items{
 final int id;
 final String name;
 final double price;
 final int quantity;
 final String description;
 final String category;
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
      quantity: json['quantity'],
      description: json['description'],
      category: json['category'],
      titleimage: json['titleImage'],
      ingredient: List<String>.from(json['ingredients']),
    );
  }
  }