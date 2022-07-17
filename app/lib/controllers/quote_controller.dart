import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/quote_model.dart';


class QuoteController {
  Future<List<Quote>> get quotes async {
    final response = await http.get(Uri.parse('http://localhost:5000/quotes'));

    if (response.statusCode == 200) {

      List<Quote> quotes = <Quote>[];

      for (var q in jsonDecode(response.body)) {
        quotes.add(Quote.fromJson(q));
      }

      return quotes;
    } else {
      throw Exception('Failed to load Quotes');
    }
  }

  void postQuote(String text, String name) async {
    String json = jsonEncode(QuoteRequest(text: text, name: name));
    final request = await http.post(
      Uri.parse('http://localhost:5000/quotes'),
      headers: {"Content-Type": "application/json"},
      body: json,
    );
  }
}