import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/new_model.dart';

class NewsApi {
  List<NewsModel> dataStore = [];

  Future<void> getNews() async {
    final Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ec2fbbd2f5f94275a053d595aaa2de53"
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] == 'ok') {
          final articles = jsonData["articles"] as List;
          dataStore = articles.map((element) {
            return NewsModel(
              title: element['title'] ?? 'No Title',
              urlToImage: (element['urlToImage'] != null && element['urlToImage'].isNotEmpty)
                  ? element['urlToImage']
                  : 'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=', // صورة افتراضية
              description: element['description'] ?? 'No Description',
              author: element['author'] ?? 'Unknown Author',
              content: element['content'] ?? 'No Content',
            );
          }).toList();
        } else {
          print('Error: ${jsonData["status"]}');
        }
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}

class CategoryNews {
  List<NewsModel> dataStore = [];

  Future<void> getNews(String category) async {
    final Uri url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=313e712139fc486796d895c700aef894"
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] == 'ok') {
          final articles = jsonData["articles"] as List;
          dataStore = articles.map((element) {
            return NewsModel(
              title: element['title'] ?? 'No Title',
              urlToImage: (element['urlToImage'] != null && element['urlToImage'].isNotEmpty)
                  ? element['urlToImage']
                  : 'https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=', // صورة افتراضية
              description: element['description'] ?? 'No Description',
              author: element['author'] ?? 'Unknown Author',
              content: element['content'] ?? 'No Content',
            );
          }).toList();
        } else {
          print('Error: ${jsonData["status"]}');
        }
      } else {
        print('Failed to load news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }
}
