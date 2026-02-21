import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_stock_manager/presentation/providers/food_provider.dart';
import 'package:event_stock_manager/presentation/widgets/food_item_card.dart';
import 'package:event_stock_manager/presentation/widgets/add_food_item_form.dart';
import 'package:event_stock_manager/core/constants/app_constants.dart';

class AlacenaScreen extends StatefulWidget {
  const AlacenaScreen({super.key});

  @override
  State<AlacenaScreen> createState() => _AlacenaScreenState();
}

class _AlacenaScreenState extends State<AlacenaScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AddFoodItemForm(
        category: AppConstants.categoryAlacena,
        onSave: (name, quantity, type, entryDate) {
          context.read<FoodProvider>().addItem(
            name: name,
            quantity: quantity,
            category: AppConstants.categoryAlacena,
            type: type,
            entryDate: entryDate,
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, item) {
    showDialog(
      context: context,
      builder: (ctx) => AddFoodItemForm(
        item: item,
        category: AppConstants.categoryAlacena,
        onSave: (name, quantity, type, entryDate) {
          final updatedItem = item.copyWith(
            name: name,
            quantity: quantity,
            type: type,
            entryDate: entryDate,
          );
          context.read<FoodProvider>().updateItem(updatedItem);
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Está seguro de que desea eliminar este artículo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<FoodProvider>().deleteItem(id);
              Navigator.of(ctx).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alacena'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar artículos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) {
                context.read<FoodProvider>().search(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<FoodProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = provider.alacenaItems;

                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shelves,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay artículos en la alacena',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Toca el botón + para agregar',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return FoodItemCard(
                      item: item,
                      onEdit: () => _showEditDialog(context, item),
                      onDelete: () => _showDeleteDialog(context, item.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}
