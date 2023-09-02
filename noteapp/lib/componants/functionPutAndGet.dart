import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

String _basicAuth = 'Basic ${base64Encode(utf8.encode('mayer:mayer123'))}';

Map<String, String> myheaders = {'authorization': _basicAuth};

class FunctionsGetAndPost {
  getRequest(String url) async {
    // when make the real server delayed 2 oe more second but this local host
    // await Future.delayed(Duration(seconds: 2));
    try {
      //get Data
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // make convert from json to dart Object
        var respnsebody = jsonDecode(response.body);
        return respnsebody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (error) {
      print('Error catch: $error');
    }
    ;
  }

  PostRequest(String url, Map data) async {
    try {
      //get Data
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        // make convert from json to dart Object
        var respnsebody = jsonDecode(response.body);
        return respnsebody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (error) {
      print('Error catch: $error');
    }
    ;
  }

  FunctionUploadWithFile(String url, Map data, File file) async {
    var request = await http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiparFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multiparFile);
    
    // to sent data with photo
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // send respnse
    var myrequest = await request.send();
    // get response
    var response = await http.Response.fromStream(myrequest);

    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error: ${myrequest.statusCode}");
    }
  }
}
