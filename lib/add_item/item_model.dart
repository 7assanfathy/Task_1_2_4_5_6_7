import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'item.dart';

class ItemModel extends ChangeNotifier {
  final List<Item> _items = [];
  final ImagePicker imagePicker = ImagePicker();
  List<File> selectedImages = [];

  List<Item> get items => _items;

  void addItem({
    required List<File> itemImages,
    required String title,
    required String body,
    required bool favorite,
  }) {
    _items.add(Item(
      images: itemImages,
      title: title,
      body: body,
      favorite: favorite,
    ));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  Future<void> imageSelector() async {
    final List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      selectedImages.addAll(images.map((image) => File(image.path)));
      notifyListeners();
    }
  }

  void removeImage(File image) {
    selectedImages.remove(image);
    notifyListeners();
  }

  Item? _selectedItem;
  Item? get selectedItem => _selectedItem;

  void selectItem(Item item) {
    _selectedItem = item;
    notifyListeners();
  }
}
