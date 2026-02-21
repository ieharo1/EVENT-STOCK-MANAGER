import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:event_stock_manager/data/models/food_item.dart';
import 'package:event_stock_manager/core/constants/app_constants.dart';

class AddFoodItemForm extends StatefulWidget {
  final FoodItem? item;
  final String category;
  final Function(String name, int quantity, String? type, DateTime entryDate) onSave;

  const AddFoodItemForm({
    super.key,
    this.item,
    required this.category,
    required this.onSave,
  });

  @override
  State<AddFoodItemForm> createState() => _AddFoodItemFormState();
}

class _AddFoodItemFormState extends State<AddFoodItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _selectedType;
  DateTime _entryDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _selectedType = widget.item!.type;
      _entryDate = widget.item!.entryDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _entryDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _entryDate) {
      setState(() {
        _entryDate = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final quantity = int.tryParse(_quantityController.text) ?? 1;
      widget.onSave(name, quantity, _selectedType, _entryDate);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final isEditing = widget.item != null;
    final showType = widget.category == AppConstants.categoryRefrigeracion;

    return AlertDialog(
      title: Text(isEditing ? 'Editar Artículo' : 'Agregar Artículo'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del artículo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fastfood),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese una cantidad';
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null || quantity < 1) {
                    return 'La cantidad debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (showType) ...[
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: AppConstants.typeRefrigerado,
                      child: Text(AppConstants.typeRefrigerado),
                    ),
                    DropdownMenuItem(
                      value: AppConstants.typeCongelado,
                      child: Text(AppConstants.typeCongelado),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de ingreso',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(dateFormat.format(_entryDate)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Actualizar' : 'Guardar'),
        ),
      ],
    );
  }
}
