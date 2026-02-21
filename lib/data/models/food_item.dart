import 'package:hive/hive.dart';

part 'food_item.g.dart';

@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String category;

  @HiveField(4)
  String? type;

  @HiveField(5)
  DateTime entryDate;

  FoodItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    this.type,
    required this.entryDate,
  });

  FoodItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? category,
    String? type,
    DateTime? entryDate,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      type: type ?? this.type,
      entryDate: entryDate ?? this.entryDate,
    );
  }
}
