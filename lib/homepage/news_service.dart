import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/homepage/home_page.dart';

class NewsService {
  Future<List<NewsModel>> fetchSearchResults(String query) async {
    final apiKey = "f5eff7c2f67b4c80b7b786c21f696b73";
    final response = await http.get(
        Uri.parse("https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey"));

    if (response.statusCode == 200) {
      final List<dynamic> rawData = json.decode(response.body)["articles"];
      return rawData.map((json) => NewsModel(
        title: json["title"] ?? "",
        imageUrl: json["urlToImage"] ?? "",
        description: json["description"] ?? "",
        content: json["content"] ?? "",
      )).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}