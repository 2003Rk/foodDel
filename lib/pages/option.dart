import 'package:flutter/material.dart';
import 'package:food_delivery/pages/login.dart';
import 'package:food_delivery/admin/admin_login.dart';
import 'package:food_delivery/pages/onboard.dart';

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Centers the buttons vertically
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Add the logo image at the top
              Container(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 60),
                  child: Image.asset(
                    'images/Group 2.png',
                    height: 100, // Adjust the height as needed
                  ),
                ),
              ),
              SizedBox(height: 160), // Adds space between the logo and the text
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Do you want to customize \n your food category => ',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminLogin()),
                      );
                    },
                    child: Text('Admin Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ), // Adds space between the text and the buttons
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onboard()),
                    );
                  },
                  child: Text('User Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
