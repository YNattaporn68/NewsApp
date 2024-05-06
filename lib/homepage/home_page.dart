import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/homepage/news_details.dart';
import 'package:newsapp/homepage/search_screen.dart';
import 'package:newsapp/homepage/widget/news_card_widget.dart';
import 'package:newsapp/profilepage/profile_page.dart';
import 'package:newsapp/welcomepage/login.dart';
import 'package:newsapp/welcomepage/welcome_page.dart';

class NewsModel {
  final String title;
  final String imageUrl;
  final String description;
  final String content;

  NewsModel({required this.title, 
  required this.imageUrl, 
  required this.description,
  required this.content,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<NewsModel>> _newsList;

  @override
  void _searchNews(BuildContext context) {
    // นำทางไปยังหน้าจอค้นหา
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _newsList = _fetchNews("general"); // Fetch general news initially
  }

  Future<List<NewsModel>> _fetchNews(String category) async {
    final apiKey = "f5eff7c2f67b4c80b7b786c21f696b73";
    final response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?language=en&category=$category&apiKey=$apiKey"));
    
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
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text("WORLDWIDE NEWS APP", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xFFC02A2A),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "General"),
              Tab(text: "Science"),
              Tab(text: "Technology"),
              Tab(text: "Business"),
              Tab(text: "Entertainment"),
              Tab(text: "Sports"),
              Tab(text: "Health"),
            ],
          ),
          actions: <Widget>[
            IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _searchNews(context),
          ),
            SizedBox(width: 10,)
          ],
        ),


        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFC02A2A),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEWS APP OPTIONS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.person , size: 50, color: Colors.white,),
                  SizedBox(height: 5),
                  Text(
                    'username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset("assets/profile_option.png"),
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset("assets/logout_option.png"),
              ),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),

      
        body: TabBarView(
          children: [
            _buildNewsListView("general"),
            _buildNewsListView("science"),
            _buildNewsListView("technology"),
            _buildNewsListView("business"),
            _buildNewsListView("entertainment"),
            _buildNewsListView("sports"),
            _buildNewsListView("health"),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsListView(String category) {
    return FutureBuilder<List<NewsModel>>(
      future: _fetchNews(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final news = snapshot.data![index];
              return NewsCardWidget(news: news, category: category);
            },
          );
        }
      },
    );
  }
}
