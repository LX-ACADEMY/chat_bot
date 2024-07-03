import 'package:chat_bot_test/secret/secret.dart';
import 'package:dio/dio.dart';

final class GeminiServices {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://generativelanguage.googleapis.com/v1'),
  );

  /// Send prompt
  static Future<dynamic> sendPrompt(String prompt) async {
    final response = await _dio.post(
      '/models/gemini-1.5-pro:generateContent',
      queryParameters: {
        "key": Secret.geminiApiKey,
      },
      data: {
        'contents': [
          {
            'parts': [
              {
                'text': prompt,
              }
            ]
          }
        ]
      },
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Server error. Please try again.');
    }
  }
}
