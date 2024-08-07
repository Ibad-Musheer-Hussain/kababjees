import 'package:kababjees/HomeScreen.dart';

class Cart {
  List<Items> items = [];

  void addItem(Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity += 1;
      print("quantity increased");
      print(items[existingItemIndex].quantity);
    } else {
      items.add(item);
      print("item added");
    }
  }

  void changequantity(Items item, int quantity) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);

    if (existingItemIndex != -1) {
      items[existingItemIndex].quantity = quantity;
      print("Quantity set to $quantity");
    } else {
      item.quantity = quantity;
      items.add(item);
      print("Item added with quantity $quantity");
    }
  }

  void removeItem(int id, Items item) {
    final existingItemIndex = items.indexWhere((i) => i.id == item.id);
    items[existingItemIndex].quantity = 1;
    items.removeWhere((item) => item.id == id);
  }

  double get totalPrice {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}
