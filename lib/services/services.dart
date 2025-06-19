import 'package:http/http.dart' as http;
import 'package:cook_buddy/utils/imports.dart';


class GeminiApiService {
  static Future<String> fetchGeminiResponse(String userInput) async {
    final prompt = '''
You're a recipe assistant.

Rules:

1. If the user gives a dish name, return:
- Title (english)
- Title (hindi)
- Ingredients (list in english)
- Ingredients (list in hindi)
- Recipe (list in english)
- Recipe (list in hindi)

2. If the user gives one or more ingredients (e.g., "potato + onion + sooji" or "potato, onion"):
- Show a list of Indian dishes (in english) that use **all** the ingredients together.
- Show a list of Indian dishes (in hindi) that use **all** the ingredients together.

3. If the input is not related to food, reply:
"Sorry"


Respond in a clean, structured format in both Hindi and English.

User query: $userInput
''';

    final body = {
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final decoded = json.decode(response.body);
    print("Full Gemini Response: ${response.body}");
    try {
      String text = decoded['candidates']?[0]?['content']?['parts']?[0]?['text'];
      if (text.isNotEmpty) {
        text = text.replaceAll('**', '');
        return text ;
      } else {
        return "Sorry, couldn't understand the response.";
      }
    } catch (e) {
      return "Sorry, something went wrong while parsing the response.";
    }
  }
}
