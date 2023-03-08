import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.imagePickFn});

  final void Function(File pickedImage) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _profileImage;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
    widget.imagePickFn(File(image!.path));
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
      radius: 50,
      child: TextButton.icon(
        onPressed: _pickImage,
        icon: Icon(
          Icons.camera_alt,
          color: _profileImage != null
              ? Theme.of(context).primaryColor.withOpacity(0.0)
              : Theme.of(context).primaryColor,
        ),
        label: Text(
          'Add',
          style: TextStyle(
            color: _profileImage != null
                ? Theme.of(context).primaryColor.withOpacity(0.0)
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
