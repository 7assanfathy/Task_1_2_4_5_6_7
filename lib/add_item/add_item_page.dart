import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/dashboard_screen.dart';
import 'item_model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/background.jpg"),
          ),
        ),
        child: Consumer<ItemModel>(
          builder: (context, itemModel, child) => ListView(
            children: [
              const SizedBox(height: 30),
              itemModel.selectedImages.isEmpty
                  ? Container(
                color: Colors.white38,
                height: 150,
                width: screenWidth - 20,
                child: IconButton(
                  onPressed: itemModel.imageSelector,
                  icon: const Icon(Icons.camera_alt),
                ),
              )
                  : Row(
                children: [
                  Container(
                    color: Colors.white38,
                    height: 100,
                    width: 100,
                    child: IconButton(
                      onPressed: itemModel.imageSelector,
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: screenWidth - 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: itemModel.selectedImages.map((file) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.file(
                                file,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  itemModel.removeImage(file);
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: body,
                  minLines: 3,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    hintText: "Body",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<ItemModel>(
        builder: (context, itemModel, child) => FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            final item = Provider.of<ItemModel>(context, listen: false);

            item.addItem(
              itemImages: List.from(item.selectedImages),
              title: title.text,
              body: body.text,
              favorite: true,
            );

            item.selectedImages.clear();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
      ),
    );
  }
}
