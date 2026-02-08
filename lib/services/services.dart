import 'package:cook_buddy/services/auto_config.dart';
import 'package:http/http.dart' as http;
import 'package:cook_buddy/utils/imports.dart';

class GeminiApiService {
  static Future<String> fetchGeminiResponse(String userInput) async {
    final prompt = '''
You are a recipe assistant. You must respond ONLY with a JSON object. Do not include any text outside the JSON.

If the user asks for a dish recipe:
{
  "type": "recipe",
  "title": "Dish Name",
  "titleHindi": "पकवान का नाम",
  "ingredients": ["item 1", "item 2"],
  "ingredientsHindi": ["सामग्री 1", "सामग्री 2"],
  "steps": ["step 1", "step 2"],
  "stepsHindi": ["चरण 1", "चरण 2"]
}

If the user gives ingredients and wants dish suggestions:
{
  "type": "suggestions",
  "dishList": ["Dish 1", "Dish 2"],
  "dishListHindi": ["पकवान 1", "पकवान 2"]
}

If the input is not food-related:
{
  "type": "error",
  "message": "Sorry, I can only help with food-related queries."
}

User query: $userInput
''';

    final body = {
      "contents": [
        {
          "parts": [
            {"text": prompt},
          ],
        },
      ],
    };

    final response = await http.post(
      Uri.parse(ApiConfig.baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final decoded = json.decode(response.body);
    debugPrint("Full Gemini Response: ${response.body}");
    try {
      String text =
          decoded['candidates']?[0]?['content']?['parts']?[0]?['text'];
      if (text.isNotEmpty) {
        text = text.replaceAll('**', '');
        text = text.replaceAll('```json', ''); // Remove JSON code block start
        text = text.replaceAll('```', ''); // Remove generic code block end
        return text.trim(); // Trim whitespace
      } else {
        return "Sorry, couldn't understand the response.";
      }
    } catch (e) {
      return "Sorry, something went wrong while parsing the response.";
    }
  }
}
