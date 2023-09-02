import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../componants/componts.dart';
import '../../componants/functionPutAndGet.dart';
import 'package:noteappphp/main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  FunctionsGetAndPost function = FunctionsGetAndPost();
  
  Login() async {
    var response = await function.PostRequest(LinkLogin, {
      "email": email.text,
      "password": password.text,
    });
    if (response != null && response['states'] == "success") {
      shardPref.setString('id', response['data']['id'].toString());
      shardPref.setString('username', response['data']['username']);
      shardPref.setString('email', response['data']['email']);
      Navigator.of(context).pushNamedAndRemoveUntil("Home", (route) => false);
    } else {
      print('Error');

      AwesomeDialog(
        context: context,
        title: 'alert',
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Email or Password Wrong Please Try Again',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
              key: FormKey,
              child: Column(
                children: [
                  Image.asset(
                    'images/imagelogin.avif',
                    width: 400,
                    height: 400,
                  ),
                  TextFormFieldBuild(
                    hint: 'Write Your email please',
                    type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Eamil must be not empty';
                      } else if (!value.contains("@")) {
                        return 'Must enter email please';
                      }
                    },
                    mycontroller: email,
                  ),
                  TextFormFieldBuild(
                    hint: 'Write Your password please',
                    type: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password must be not empty\nplease enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                    },
                    mycontroller: password,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (FormKey.currentState!.validate()) {
                        await Login();
                      }
                    },
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    child: Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('If Not Have account -> '),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('signup');
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
