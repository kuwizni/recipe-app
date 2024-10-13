import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  final String foodName;
  final List<String>? ingredients;
  final List<String>? steps;

  const RecipeDetail({
    Key? key,
    required this.foodName,
    this.ingredients,
    this.steps,
  }) : super(key: key);

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  late Map<String, bool> ingredientChecklist;
  late Map<String, bool> stepsChecklist;

  @override
  void initState() {
    super.initState();
    ingredientChecklist = {
      for (var ingredient in widget.ingredients ?? []) ingredient: false
    };
    stepsChecklist = {for (var step in widget.steps ?? []) step: false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingredients:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.ingredients?.length ?? 0,
                itemBuilder: (context, index) {
                  final ingredient = widget.ingredients![index];
                  return CheckboxListTile(
                    title: Text(ingredient),
                    value: ingredientChecklist[ingredient],
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (bool? value) {
                      setState(() {
                        ingredientChecklist[ingredient] = value!;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Steps:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.steps?.length ?? 0,
                itemBuilder: (context, index) {
                  final step = widget.steps![index];
                  return CheckboxListTile(
                    title: Text(step),
                    value: stepsChecklist[step],
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (bool? value) {
                      setState(() {
                        stepsChecklist[step] = value!;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
