import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projects/quote/quote.dart';

Future<List<Quote>> fetchQuote() async {
  final response = await http.get(
    Uri.parse("https://api.api-ninjas.com/v1/quotes"),

    headers: {
      'X-Api-Key': 'UAGmXIKt8X0Yxthcr9WozQ==BwOdVZsb0b36aj9C'
    },

  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Quote.fromJson(json)).toList();
  }

  throw Exception("Failed to load data");
}
