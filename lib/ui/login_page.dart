import 'package:firestore_crud_with_provider/provider/user_provider.dart';
import 'package:firestore_crud_with_provider/ui/followers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();

  _getUser() {
    if (controller.text.isEmpty) {
      //show error
      Provider.of<UserProvider>(context, listen: false)
          .setErrorMessage("Please enter user name");
    } else {
      //fetch data
      Provider.of<UserProvider>(context, listen: false)
          .fetchUser(controller.text)
          .then((value) {
        if (value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FollowersPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api testing"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                Provider.of<UserProvider>(context, listen: false)
                    .setErrorMessage(null);
              },
              enabled:
                  !Provider.of<UserProvider>(context, listen: false).loading(),
              controller: controller,
              decoration: InputDecoration(
                hintText: "enter github name",
              ),
            ),
            MaterialButton(
              onPressed: () {
                _getUser();
              },
              child: Provider.of<UserProvider>(context, listen: false).isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text("log in"),
              colorBrightness: Brightness.light,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none),
            )
          ],
        ),
      ),
    );
  }
}
