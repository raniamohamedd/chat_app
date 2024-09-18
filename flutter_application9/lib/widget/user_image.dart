// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({
    Key? key,
    required this.onpicked,
  }) : super(key: key);
  final void Function(File pickedimage) onpicked;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? pickerimagefile;
       void picked() async {
 final pickedimage =  await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 150,imageQuality: 50);
 if(pickedimage==null){return;}
 setState(() {
   pickerimagefile = File(pickedimage.path);
 });
 widget.onpicked(pickerimagefile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:pickerimagefile==null? null: FileImage(pickerimagefile!),
        ),
        TextButton.icon(
          onPressed:picked,
          label: Text(
            'add image',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          icon: Icon(Icons.image),
        )
      ],
    );
  }
}
