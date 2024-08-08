import 'package:flutter/material.dart';
import 'package:newsapp/Screen/news_detail.dart';
import 'package:newsapp/Services/services.dart';
import '../model/new_model.dart';

class SelectedCategoryNews extends StatefulWidget {
  final String category;

  const SelectedCategoryNews({super.key, required this.category});

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  List<NewsModel> articles = [];
  bool isLoading = true;

  Future<void> getNews() async {
    CategoryNews news = CategoryNews();
    await news.getNews(widget.category);
    print("Fetched articles: ${news.dataStore}"); // طباعة البيانات للتحقق منها
    setState(() {
      articles = news.dataStore;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 66, 105),
        foregroundColor: Colors.white,
        title: Text(
          widget.category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetail(newsModel: article),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        if (article.urlToImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.urlToImage!,
                              height: 250,
                              width: double.infinity, // تغيير العرض ليتناسب مع حجم الشاشة
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Container(
                            height: 250,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Text('No Image Available'),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          article.title ?? 'No Title Available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Divider(thickness: 2),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
