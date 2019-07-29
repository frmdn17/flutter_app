import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/HomeScreen.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool checkValue = false;
  SharedPreferences sharedPreferences;


  @override
  void initState() {
    super.initState();
    getCredential();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: new SingleChildScrollView(
        child: _body(),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _body() {
    return new Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(30.0),
            child: new Image.network(
              'https://picsum.photos/250?image=9',
            ),
          ),
          new TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
          new TextField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
          new CheckboxListTile(
            value: checkValue,
            onChanged: _onChanged,
            title: Text('Remember Me'),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          new Container(
            decoration:
            new BoxDecoration(border: Border.all(color: Colors.lightBlue)),
            child: new ListTile(
              title: new Text(
                "Login",
                textAlign: TextAlign.center,
              ),
              onTap: _navigator,
            ),
          )
        ],
      ),
    );
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("check", value);
    await sharedPreferences.setString("email", email.text);
    await sharedPreferences.setString("password", password.text);
    setState(() {
      checkValue = value;
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      if (checkValue != null) {
        if (checkValue) {
          email.text = sharedPreferences.getString("email");
          password.text = sharedPreferences.getString("password");
        } else {
          email.text = "";
          password.text = "";
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() async {
    if (email.text != "faisal123@gmail.com" || password.text != "faisal123") {
      showDialog(
          context: context,
          barrierDismissible: false,
          child: new CupertinoAlertDialog(
            content: new Text(
              "Incorrect Email Or Password",
              style: new TextStyle(fontSize: 14.0),
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("Ok")),
            ],
          ));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
              builder: (BuildContext context) => new HomeScreen()),
              (Route<dynamic> route) => false);
    }
  }

}

