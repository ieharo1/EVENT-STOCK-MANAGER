import 'package:uuid/uuid.dart';
import 'package:event_stock_manager/data/models/food_item.dart';
import 'package:event_stock_manager/data/database/database_service.dart';

class FoodRepository {
  final DatabaseService _databaseService;
  final Uuid _uuid = const Uuid();

  FoodRepository(this._databaseService);

  Future<FoodItem> createItem({
    required String name,
    required int quantity,
    required String category,
    String? type,
    required DateTime entryDate,
  }) async {
    final item = FoodItem(
      id: _uuid.v4(),
      name: name,
      quantity: quantity,
      category: category,
      type: type,
      entryDate: entryDate,
    );
    await _databaseService.addItem(item);
    return item;
  }

  Future<void> updateItem(FoodItem item) async {
    await _databaseService.updateItem(item);
  }

  Future<void> deleteItem(String id) async {
    await _databaseService.deleteItem(id);
  }

  FoodItem? getItem(String id) {
    return _databaseService.getItem(id);
  }

  List<FoodItem> getAllItems() {
    return _databaseService.getAllItems();
  }

  List<FoodItem> getItemsByCategory(String category) {
    return _databaseService.getItemsByCategory(category);
  }

  List<FoodItem> searchItems(String query, {String? category}) {
    return _databaseService.searchItems(query, category);
  }
}
