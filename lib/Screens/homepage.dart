import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app_mobile/Models/recipebook.dart';
import 'package:recipe_app_mobile/Screens/addrecipe.dart';
import 'package:recipe_app_mobile/Screens/loginpage.dart';
import 'recipedetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFoodType;
  List<RecipeBook> _recipes = [];
  List<String> _foodTypes = [];

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    String jsonString = await rootBundle.loadString('assets/recipetypes.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _recipes = jsonResponse.map((json) => RecipeBook.fromJson(json)).toList();
      _foodTypes =
          _recipes.map((recipe) => recipe.foodType ?? 'Other').toSet().toList();
      _foodTypes.insert(0, 'All Recipes');
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newRecipe = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipe(foodTypes: _foodTypes),
                ),
              );
              if (newRecipe != null) {
                setState(() {
                  _recipes.add(newRecipe);
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedFoodType,
              hint: const Text('Select a food type'),
              icon: const Icon(Icons.arrow_drop_down),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _foodTypes.map((String foodType) {
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _selectedFoodType == null ||
                        _selectedFoodType == 'All Recipes'
                    ? _recipes.length
                    : _recipes
                        .where((recipe) => recipe.foodType == _selectedFoodType)
                        .length,
                itemBuilder: (context, index) {
                  final recipe = _selectedFoodType == null ||
                          _selectedFoodType == 'All Recipes'
                      ? _recipes[index]
                      : _recipes
                          .where(
                              (recipe) => recipe.foodType == _selectedFoodType)
                          .toList()[index];
                  return buildRecipeCard(recipe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecipeCard(RecipeBook recipe) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(
                foodName: recipe.foodName ?? 'Unknown',
                ingredients: recipe.ingredients,
                steps: recipe.steps,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.foodName ?? 'Unknown',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
