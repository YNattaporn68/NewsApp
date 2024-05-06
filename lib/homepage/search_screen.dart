import 'package:flutter/material.dart';
import 'package:newsapp/homepage/home_page.dart';
import 'package:newsapp/homepage/news_details.dart';
import 'package:newsapp/homepage/news_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NewsModel> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchNews(BuildContext context, String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final newsService = NewsService();
      List<NewsModel> searchResults = await newsService.fetchSearchResults(query);
      setState(() {
        _searchResults = searchResults;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error searching news: $e');
      // จัดการกับข้อผิดพลาดเมื่อไม่สามารถค้นหาข่าวได้
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'search news',
          ),
          onSubmitted: (value) {
            _searchNews(context, value);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
  if (_searchResults.isEmpty) {
    return Center(child: Text('No result'));
  } else {
    List<NewsModel> newsWithImages = _searchResults.where((news) => news.imageUrl.isNotEmpty).toList();
    return ListView.builder(
      itemCount: newsWithImages.length,
      itemBuilder: (context, index) {
        final news = newsWithImages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // กำหนดระยะห่างในแนวดิ่งระหว่างข่าว
          child: ListTile(
            title: Text(
              news.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Image.network(
              news.imageUrl,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsDetails(news: news, category: 'General',)),
              );
            },
          ),
        );
      },
    );
  }
}
}