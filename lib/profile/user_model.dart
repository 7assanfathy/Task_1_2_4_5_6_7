import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/profile/user.dart';

class UserModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();

  //File? selectedImage;

  User? _user;

  User? get user => _user;

  Future<void> imageSelector(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      if (_user != null) {
        _user?.image = File(image.path);
      } else {
        _user = User(
          name: " Nour",
          bio: "Code Sleep Eat Repeat",
          image: File(image.path),
        );
      }

      notifyListeners();
    }
  }
}
