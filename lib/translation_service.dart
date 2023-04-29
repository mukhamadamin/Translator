import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String apiKey = 'YOUR_GOOGLE_API_KEY';

  Future<String> translate(String text, String targetLanguage) async {
    final url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final body = jsonEncode({
      'q': text,
      'target': targetLanguage,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Ошибка перевода');
    }
  }
}