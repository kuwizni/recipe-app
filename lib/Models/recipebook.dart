class RecipeBook {
  String? foodName;
  String? foodType; 
  List<String>? ingredients;
  List<String>? steps;

  RecipeBook({this.foodName, this.foodType, this.ingredients, this.steps});

  RecipeBook.fromJson(Map<String, dynamic> json) {
    foodName = json["food_name"];
    foodType = json["food_type"]; 
    ingredients = json["ingredients"] == null ? null : List<String>.from(json["ingredients"]);
    steps = json["steps"] == null ? null : List<String>.from(json["steps"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["food_name"] = foodName;
    _data["food_type"] = foodType; 
    if (ingredients != null) {
      _data["ingredients"] = ingredients;
    }
    if (steps != null) {
      _data["steps"] = steps;
    }
    return _data;
  }
}
