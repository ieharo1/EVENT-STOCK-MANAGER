import 'package:flutter/foundation.dart';
import 'package:event_stock_manager/data/models/food_item.dart';
import 'package:event_stock_manager/data/repositories/food_repository.dart';
import 'package:event_stock_manager/core/constants/app_constants.dart';

class FoodProvider extends ChangeNotifier {
  final FoodRepository _repository;
  
  List<FoodItem> _refrigeracionItems = [];
  List<FoodItem> _alacenaItems = [];
  List<FoodItem> _filteredRefrigeracion = [];
  List<FoodItem> _filteredAlacena = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;

  FoodProvider(this._repository);

  List<FoodItem> get refrigeracionItems => 
      _searchQuery.isEmpty ? _refrigeracionItems : _filteredRefrigeracion;
  List<FoodItem> get alacenaItems => 
      _searchQuery.isEmpty ? _alacenaItems : _filteredAlacena;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _refrigeracionItems = _repository.getItemsByCategory(AppConstants.categoryRefrigeracion);
      _alacenaItems = _repository.getItemsByCategory(AppConstants.categoryAlacena);
      _refrigeracionItems.sort((a, b) => b.entryDate.compareTo(a.entryDate));
      _alacenaItems.sort((a, b) => b.entryDate.compareTo(a.entryDate));
      _applySearch();
    } catch (e) {
      _error = 'Error al cargar los elementos: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredRefrigeracion = [];
      _filteredAlacena = [];
    } else {
      _filteredRefrigeracion = _refrigeracionItems
          .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
      _filteredAlacena = _alacenaItems
          .where((item) => item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  Future<void> addItem({
    required String name,
    required int quantity,
    required String category,
    String? type,
    required DateTime entryDate,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.createItem(
        name: name,
        quantity: quantity,
        category: category,
        type: type,
        entryDate: entryDate,
      );
      await loadItems();
    } catch (e) {
      _error = 'Error al agregar el elemento: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateItem(FoodItem item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.updateItem(item);
      await loadItems();
    } catch (e) {
      _error = 'Error al actualizar el elemento: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteItem(id);
      await loadItems();
    } catch (e) {
      _error = 'Error al eliminar el elemento: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}
