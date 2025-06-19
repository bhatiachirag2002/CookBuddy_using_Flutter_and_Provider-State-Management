class RecipeResponse {
  final String title;
  final String titleHindi;
  final List<String> ingredients;
  final List<String> ingredientsHindi;
  final List<String> steps;
  final List<String> stepsHindi;
  final List<String> dishList;
  final List<String> dishListHindi;
  final String error;

  RecipeResponse({
    this.title = '',
    this.titleHindi = '',
    this.ingredients = const [],
    this.ingredientsHindi = const [],
    this.steps = const [],
    this.stepsHindi = const [],
    this.dishList = const [],
    this.dishListHindi = const [],
    this.error = '',
  });
}
