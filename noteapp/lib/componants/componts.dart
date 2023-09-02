import 'package:flutter/material.dart';


// SharedPreferences? shardPref;
// Links api

const String LinkServerName = 'http://localhost/coursphp';
const String LinkImageRout = 'http://localhost/coursphp/Upload';

//auth links
const String LinkSignUp = '$LinkServerName/auth/signup.php';
const String LinkLogin = '$LinkServerName/auth/login.php';

//Links notes
const String LinkAddNote = '$LinkServerName/notes/add.php';
const String LinkDeleteNote = '$LinkServerName/notes/delete.php';
const String LinkViewNote = '$LinkServerName/notes/view.php';
const String LinkUpdateNote = '$LinkServerName/notes/edit.php';


////TextFormFieldBuild
class TextFormFieldBuild extends StatelessWidget {
  const TextFormFieldBuild(
      {super.key,
      required this.hint,
      this.type,
      this.validator,
      required this.mycontroller});
  final String hint;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final TextEditingController mycontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: mycontroller,
        keyboardType: type,
        validator: validator,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
                vertical: 5, horizontal: 10), // padding inside box
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
      ),
    );
  }
}
