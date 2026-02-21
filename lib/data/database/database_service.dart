import 'package:hive_flutter/hive_flutter.dart';
import 'package:event_stock_manager/data/models/food_item.dart';
import 'package:event_stock_manager/core/constants/app_constants.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Box<FoodItem>? _box;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FoodItemAdapter());
    _box = await Hive.openBox<FoodItem>(AppConstants.hiveBoxName);
  }

  Box<FoodItem> get box {
    if (_box == null) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return _box!;
  }

  Future<void> addItem(FoodItem item) async {
    await box.put(item.id, item);
  }

  Future<void> updateItem(FoodItem item) async {
    await box.put(item.id, item);
  }

  Future<void> deleteItem(String id) async {
    await box.delete(id);
  }

  FoodItem? getItem(String id) {
    return box.get(id);
  }

  List<FoodItem> getAllItems() {
    return box.values.toList();
  }

  List<FoodItem> getItemsByCategory(String category) {
    return box.values.where((item) => item.category == category).toList();
  }

  List<FoodItem> searchItems(String query, String? category) {
    List<FoodItem> items = box.values.toList();
    if (category != null) {
      items = items.where((item) => item.category == category).toList();
    }
    if (query.isNotEmpty) {
      items = items.where((item) => 
        item.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    return items;
  }
}
