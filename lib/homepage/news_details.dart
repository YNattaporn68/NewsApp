import 'package:flutter/material.dart';
import 'package:newsapp/homepage/home_page.dart';

class NewsDetails extends StatelessWidget {
  final NewsModel news;
  final String category;

  const NewsDetails({Key? key, required this.news, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                news.imageUrl, 
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 250,
          ),
          SliverFillRemaining(
            child: newsDetailSection(),
          )
        ],
      ),
    );
  }

  Widget newsDetailSection() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row1(),
        SizedBox(height: 15),
        Text(
          news.title,
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          child: Divider(color: Colors.grey, thickness: 2),
          width: 100,
        ),
        SizedBox(height: 15),
        Expanded(
            child: SingleChildScrollView(
              child: Text(
                news.description, // แสดงเนื้อหาข่าวจากฟิลด์ content
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
      ],
      ),
    );
  }

  Widget row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.all(5), 
            decoration: BoxDecoration(
              color: Color(0xFFC02A2A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Row(
        //     children: [IconButton(icon: Icon(Feather.moon), onPressed: null )],
        //   ),
        // )//
      ],
    );
  }
}