import 'package:flutter/material.dart';
import 'package:newsapp/profilepage/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),  
            title: Text("PROFILE PAGE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),  
            backgroundColor: Color(0xFFC02A2A),
            centerTitle: true,
          ),
          SliverFillRemaining(
            child: profileSection(),
          )
        ],
      ),
    );
  }

  Widget profileSection() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          SizedBox(height: 50),
          Icon(Icons.person , size: 120),
          SizedBox(height: 10),
          Text("user.email@gmail.com", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700],fontSize: 15),), //Text
          const SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          MyTextBox(
            text: 'username',
            sectionName: 'username',
            onPressed: () => editField('username'),
          ),
          // Bio
          MyTextBox(
            text: 'dd / mm / yyyy',
            sectionName: 'date of birth',
            onPressed: () => editField('bio'),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  void editField(String sectionName) {
    TextEditingController _controller;
    if (sectionName == 'username') {
      _controller = _usernameController;
    } else if (sectionName == 'date of birth') {
      _controller = _dobController;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $sectionName'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(hintText: 'Enter new $sectionName'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Handle saving here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}