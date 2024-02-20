import "package:hive/hive.dart";

part "product.g.dart";

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String obs;

  @HiveField(3)
  String category;

  @HiveField(4)
  bool isKilograms;

  @HiveField(5)
  double? price;

  @HiveField(6)
  double? amount;

  @HiveField(7)
  bool isPurchased;

  Product({
    required this.id,
    required this.name,
    required this.obs,
    required this.category,
    required this.isKilograms,
    required this.isPurchased,
    this.price,
    this.amount,
  });

  Product.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        obs = map["obs"],
        category = map["category"],
        isKilograms = map["isKilograms"],
        isPurchased = map["isPurchased"],
        price = map["price"],
        amount = map["amount"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "obs": obs,
      "category": category,
      "isKilograms": isKilograms,
      "isPurchased": isPurchased,
      "price": price,
      "amount": amount,
    };
  }
}
