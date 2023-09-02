import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../componants/componts.dart';
import '../componants/functionPutAndGet.dart';

class EditNotes extends StatefulWidget {
  final notes;
  const EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController TitleController = TextEditingController();
  TextEditingController ContentController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  FunctionsGetAndPost function = FunctionsGetAndPost();
  bool isloading = false;
  File? myfile;

  editnote() async {
    setState(() {
      isloading = true;
    });
    var response;
    if (myfile == null) {
      response = await function.PostRequest(LinkUpdateNote, {
        'Title': TitleController.text,
        'Content': ContentController.text,
        'notesId': widget.notes['notesId'].toString(),
        'imageName': widget.notes['imagename'].toString(),
      });
    } else {
      response = await function.FunctionUploadWithFile(
          LinkUpdateNote,
          {
            'Title': TitleController.text,
            'Content': ContentController.text,
            'notesId': widget.notes['notesId'].toString(),
            // 'imageName': widget.notes['imagename'].toString(),
          },
          myfile!);
    }
    setState(() {
      isloading = false;
    });
    if (response['status'] == "success") {
      Navigator.of(context).pushReplacementNamed('Home');
    }
    ;
  }

  @override
  void initState() {
    TitleController.text = widget.notes['notesTitle'];
    ContentController.text = widget.notes['notesContent'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Note"),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 10),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: TitleController,
                        maxLines: null,
                        onChanged: (text) {},
                        decoration: InputDecoration(
                          hintText: 'Write Your Title..',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title must be not empty';
                          }
                        }),
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            controller: ContentController,
                            maxLines: null,
                            onChanged: (text) {},
                            decoration: InputDecoration(
                              hintText: 'Write Your Content..',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Content must be not empty';
                              }
                            }),
                      ),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () async {
                        if (FormKey.currentState!.validate()) {
                         await editnote();
                        }
                      },
                      color: const Color.fromRGBO(3, 169, 244, 1),
                      textColor: Colors.white,
                      child: Text('Save'),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () async {
                        //if (FormKey.currentState!.validate()) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Choose Photo',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text('From Gallery'),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text('From Camera'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                        //}
                      },
                      color: myfile == null
                          ? Color.fromRGBO(3, 169, 244, 1)
                          : Colors.green,
                      textColor: Colors.white,
                      child: Text('Chosse Photo'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
