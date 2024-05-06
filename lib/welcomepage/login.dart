import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:newsapp/homepage/home_page.dart';
import 'package:newsapp/welcomepage/model/profile.dart';
import 'package:newsapp/welcomepage/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late Profile profile;

  @override
  void initState() {
    super.initState();
    profile = Profile(email: '', password: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDADADA),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 80% ของความกว้างของหน้าจอ
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      Image.asset("assets/login_icon.jpg"),
                      SizedBox(height: 30),
                      //Text("Email", style: TextStyle(fontSize: 20)),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your email',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.person),
                          ), // เพิ่ม hint text ที่ต้องการแสดงในกล่อง input
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Please input your email."),
                          EmailValidator(errorText: "Invalid email address.")
                        ]),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String? email) {
                          if (email != null) {
                            profile.email = email;
                          }
                        },
                      ),
                      
                      SizedBox(height: 15),
                      //Text("Password", style: TextStyle(fontSize: 20)),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Your password', // เพิ่ม hint text ที่ต้องการแสดงในกล่อง input
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.lock),
                          ),
                        ),
                        validator: RequiredValidator(errorText: "Please input your password."),
                        obscureText: true, 
                        onSaved: (String? password) {
                          if (password != null) {
                            profile.password = password;
                          }
                        }, 
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account ?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                color: Color(0xFFC02A2A),
                                decoration: TextDecoration.combine([
                                  TextDecoration.underline,
                                ]),
                                decorationColor: Color(0xFFC02A2A),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFC02A2A)),
                            foregroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 235, 235, 235)),
                          ),
                          child: Text("LOGIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              formKey.currentState?.save();
                              print("email = ${profile.email} password = ${profile.password}");
                              formKey.currentState?.reset();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}