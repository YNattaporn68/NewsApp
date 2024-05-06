import 'package:flutter/material.dart';
import 'package:newsapp/homepage/home_page.dart';
import 'package:newsapp/homepage/news_details.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel news;
  final String category;

  const NewsCardWidget({Key? key, required this.news, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ตรวจสอบว่า imageUrl ไม่เป็น null และไม่เป็น empty string
    if (news.imageUrl != null && news.imageUrl!.isNotEmpty) {
      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsDetails(news: news,category: category)),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(news.imageUrl!),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      news.title ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      // ถ้าไม่มี imageUrl หรือเป็นค่าว่าง ไม่สร้าง Widget ของข่าวเลย
      return SizedBox.shrink();
    }
  }
}