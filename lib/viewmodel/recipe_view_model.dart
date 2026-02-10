import 'package:cook_buddy/utils/imports.dart';

class RecipeViewModel extends ChangeNotifier {
  RecipeResponse response = RecipeResponse();
  bool isLoading = false;

  Future<void> getResponse(String userInput) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await GeminiApiService.fetchGeminiResponse(userInput);
      final Map<String, dynamic> data = json.decode(result);
      final String type = data['type'] ?? '';

      if (type == 'recipe') {
        response = RecipeResponse(
          title: data['title'] ?? '',
          titleHindi: data['titleHindi'] ?? '',
          ingredients: List<String>.from(data['ingredients'] ?? []),
          ingredientsHindi: List<String>.from(data['ingredientsHindi'] ?? []),
          steps: List<String>.from(data['steps'] ?? []),
          stepsHindi: List<String>.from(data['stepsHindi'] ?? []),
        );
      } else if (type == 'suggestions') {
        response = RecipeResponse(
          dishList: List<String>.from(data['dishList'] ?? []),
          dishListHindi: List<String>.from(data['dishListHindi'] ?? []),
        );
      } else if (type == 'error') {
        response = RecipeResponse(error: data['message'] ?? 'Sorry');
      } else {
        response = RecipeResponse(error: "Unexpected response format");
      }
    } catch (e) {
      response = RecipeResponse(error: "Something went wrong!");
    }
    isLoading = false;
    notifyListeners();
  }
}
