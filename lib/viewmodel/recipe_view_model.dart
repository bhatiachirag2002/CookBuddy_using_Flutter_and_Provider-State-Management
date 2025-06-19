import 'package:cook_buddy/utils/imports.dart';


class RecipeViewModel extends ChangeNotifier{
  RecipeResponse response = RecipeResponse();
  bool isLoading = false;

  Future<void> getResponse(String userInput) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await GeminiApiService.fetchGeminiResponse(userInput);

      if (result.contains("Sorry")) {
        response = RecipeResponse(error: result);
      } else if (result.contains("Ingredients:") && result.contains("Recipe:")) {
        final title = result.split("Title:")[1].split("Title (Hindi):")[0].trim();
        final titleHindi = result.split("Title (Hindi):")[1].split("Ingredients:")[0].trim();
        final ingredientsEnglish = result.split("Ingredients:")[1].split("Ingredients (Hindi):")[0].trim();
        final ingredientsHindi = result.split("Ingredients (Hindi):")[1].split("Recipe:")[0].trim();
        final recipeEnglish = result.split("Recipe:")[1].split("Recipe (Hindi):")[0].trim();
        final recipeHindi = result.split("Recipe (Hindi):")[1].trim();

        response = RecipeResponse(
          title: title,
          titleHindi: titleHindi,
          ingredients: ingredientsEnglish.split("\n").map((e) => e.replaceAll("*", "").trim()).where((e) => e.isNotEmpty).toList(),
          ingredientsHindi: ingredientsHindi.split("\n").map((e) => e.replaceAll("*", "").trim()).where((e) => e.isNotEmpty).toList(),
          steps: recipeEnglish.split("\n").map((e) => e.replaceAll(RegExp(r'^\d+\.\s*'), '').trim()).where((e) => e.isNotEmpty).toList(),
          stepsHindi: recipeHindi.split("\n").map((e) => e.replaceAll(RegExp(r'^\d+\.\s*'), '').trim()).where((e) => e.isNotEmpty).toList(),
        );
      } else {
        final dishesEnglishRaw = result.split("English")[1].split("Hindi")[0].trim();
        final dishesHindiRaw = result.split("Hindi")[1].trim();

        List<String> parseDishList(String raw) {
          return raw
              .split('\n')
              .map((e) => e.replaceAll("*", "").trim())
              .where((e) =>
          e.isNotEmpty &&
              e.toLowerCase() != "dishes:" &&
              e.toLowerCase() != "व्यंजन:")
              .toList();
        }

        response = RecipeResponse(
          dishList: parseDishList(dishesEnglishRaw),
          dishListHindi: parseDishList(dishesHindiRaw),
        );
      }
    } catch (e) {
      response = RecipeResponse(error: "Something went wrong!");
    }
    isLoading = false;
    notifyListeners();
  }

}
