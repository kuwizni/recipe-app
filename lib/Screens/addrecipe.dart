import 'package:flutter/material.dart';
import 'package:recipe_app_mobile/Models/recipebook.dart';

class AddRecipe extends StatefulWidget {
  final List<String> foodTypes;

  AddRecipe({required this.foodTypes});

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  String? _selectedFoodType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedFoodType,
              hint: const Text('Select a food type'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: widget.foodTypes.map((String foodType) {
                return DropdownMenuItem<String>(
                  value: foodType,
                  child: Text(foodType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFoodType = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _foodNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Food Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ingredientsController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingredients (comma separated)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _stepsController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Steps (comma separated)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addRecipe,
              child: const Text('Add Recipe'),
            ),
          ],
        ),
      ),
    );
  }

  void _addRecipe() {
    final foodName = _foodNameController.text;
    final ingredients = _ingredientsController.text.split(',').map((i) => i.trim()).toList();
    final steps = _stepsController.text.split(',').map((i) => i.trim()).toList();

    final newRecipe = RecipeBook(
      foodName: foodName,
      foodType: _selectedFoodType,
      ingredients: ingredients,
      steps: steps,
    );

    Navigator.pop(context, newRecipe);
  }
}
