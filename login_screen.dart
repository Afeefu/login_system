import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showBoom = false;
  bool changeDecoration = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: changeDecoration ? Colors.blue : Colors.grey,
                  width: changeDecoration ? 3.0 : 1.0,
                ),
                borderRadius:
                    BorderRadius.circular(changeDecoration ? 15.0 : 5.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                border: Border.all(
                  color: changeDecoration ? Colors.blue : Colors.grey,
                  width: changeDecoration ? 3.0 : 1.0,
                ),
                borderRadius:
                    BorderRadius.circular(changeDecoration ? 15.0 : 5.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showBoom = !showBoom;
                });
              },
              child: Text('Show Boom'),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: showBoom ? 200.0 : 0.0,
              height: showBoom ? 100.0 : 0.0,
              color: Colors.red,
              alignment: Alignment.center,
              child: showBoom
                  ? Text(
                      'Boom',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : null,
              onEnd: () {
                if (showBoom) {
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      showBoom = false;
                    });
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  changeDecoration = !changeDecoration;
                });
              },
              child: Text('Change Decoration'),
            ),
          ],
        ),
      ),
    );
  }
}
