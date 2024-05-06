import 'package:flutter/material.dart';
import 'package:newsapp/welcomepage/login.dart';
import 'package:newsapp/welcomepage/register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"), // กำหนดรูปภาพพื้นหลัง
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "WELCOME TO NEWS APP",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Image.network(
                    "https://cdn.discordapp.com/attachments/1006050537709506594/1236694963404804126/Screenshot_2024-05-05_220332-removebg-preview.png?ex=6638f16f&is=66379fef&hm=e26c04ffa80dbc7a84dcd9798c2b587a17511a0b44c227e30e9ec9bcd870bbe5",
                    height: 250,
                  ),
                  SizedBox(height: 100),
                  SizedBox(
                    height: 80,
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFFC02A2A),
                      ),
                      child: TextButton.icon(
                        icon: Icon(Icons.login, color: Color.fromARGB(255, 252, 252, 252)),
                        label: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 252, 252, 252),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    width: 300,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add, color: Color.fromARGB(255, 252, 252, 252)),
                      label: Text(
                        "SIGNUP",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF6B6B6B)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
