import 'package:flutter/material.dart';
import 'package:noteappphp/app/editnotes.dart';
import 'package:noteappphp/componants/NoteModel.dart';
import 'package:noteappphp/componants/cardnote.dart';
import 'package:noteappphp/componants/componts.dart';
import '../componants/functionPutAndGet.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FunctionsGetAndPost function = FunctionsGetAndPost();
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> GetNotes() async {
    var response = await function.PostRequest(LinkViewNote, {
      'userid': shardPref.getString('id'),
    });
    return response;
  }

  String? Id;
  String? imagename;
  DeleteNotes({required Id, required imagename}) async {
    var response = await function.PostRequest(LinkDeleteNote, {
      'notesId': Id,
       "imagename":imagename
    });
    if (response['states'] == "success") {
      Navigator.of(context).pushReplacementNamed('Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          TextButton(
              onPressed: () {
                shardPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              child: Text(
                'SignUp',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('AddNotes');
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: GetNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!['states'] == 'fail') {
                        return const Center(
                            child: Text('Not Found Any Notes For You'));
                      }
                      return ListView.builder(
                          shrinkWrap: true, // make it size = size data comeing

                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!['data'].length,
                          itemBuilder: (context, index) {
                            return cardWidget(
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                          notes: snapshot.data!['data'][index],
                                        )));
                              },
                              model: NoteModel.fromJson(
                                  snapshot.data!['data'][index]),
                              onPressed: () {
                                setState(() {
                                  DeleteNotes(
                                      Id: snapshot.data!['data'][index]
                                              ['notesId']
                                          .toString() ,
                                          imagename: snapshot.data!['data'][index]
                                              ['imagename'].toString(),
                                          
                                          
                                          );
                                         
                                });
                              },
                            );
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
