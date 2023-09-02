

import 'package:flutter/material.dart';
import 'package:noteappphp/componants/componts.dart';

import 'NoteModel.dart';





class cardWidget extends StatelessWidget {
  const cardWidget(
      {super.key,
      required this.ontap,
      required this.onPressed,
      required this.model});

  final void Function() ontap;
  final NoteModel model;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  '$LinkImageRout/${model.imagename}',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text('${model.notesTitle}'),
                  subtitle: Text('${model.notesContent}'),
                )),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.delete,
                  color: Colors.lightBlue,
                ))
          ],
        ),
      ),
    );
  }
}
