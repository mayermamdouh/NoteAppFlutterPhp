import 'package:flutter/material.dart';

import '../../componants/componts.dart';
import '../../componants/functionPutAndGet.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _loginState();
}

class _loginState extends State<signup> {
  FunctionsGetAndPost function = FunctionsGetAndPost();

  TextEditingController email = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  signUp() async {
    var response = await function.PostRequest(LinkSignUp, {
      "username": username.text,
      "email": email.text,
      "password": password.text,
    });
    if (response['states'] == "success") {
      //pushNamedAndRemoveUntil remove every pages from stack to not return to login page
      Navigator.of(context).pushNamedAndRemoveUntil('Home', (route) => false);
    } else {
      print('Fail to Sign up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: FormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop("login");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        Text(
                          'Back',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  'images/imagelogin.avif',
                  width: 400,
                  height: 400,
                ),
                TextFormFieldBuild(
                  hint: 'Write Your username please',
                  type: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'User name must be not empty';
                    }
                  },
                  mycontroller: username,
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
                      await signUp();
                    }
                  },
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    'SignUp',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
