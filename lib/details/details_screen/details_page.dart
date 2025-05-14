import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projects/profile/profile_page/profile_page.dart';
import 'package:projects/profile/user_model.dart';
import '../../add_item/add_item_page.dart';
import '../../add_item/item_model.dart';
import '../details_widget/details_widget.dart';

class DetailsPage extends StatelessWidget {
  // final String? title;
  // final String? body;
  // final List<File>? image;

  const DetailsPage({
    // this.image, this.title, this.body,
    super.key});

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The ${items.selectedItem!.title ?? "Tree"}"),
        actions: [
          Consumer<UserModel>(
            builder: (context, userModel, _) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child:
                      userModel.user?.image != null
                          ? CircleAvatar(
                            radius: 20,
                            backgroundImage: FileImage(userModel.user!.image!),
                          )
                          : Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
         //   image == null || image!.isEmpty ? Image.asset("assets/Tree.jpg"):
             Image.file(
               items.selectedItem!.images.first,
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 FavoriteWidget(index: items.items.indexOf(items.selectedItem!),),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text( items.selectedItem!.body
                   // ?? "Hi.", textAlign: TextAlign.justify),
              )),
            // image == null || image!.isEmpty
            //     ? Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: const [
            //         MySeason(url: "assets/Tree_new.jpg", text: "Spring"),
            //         MySeason(url: "assets/Tree_old.jpg", text: "Fall"),
            //       ],
            //     )
                SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: items.selectedItem!.images.length,
                    itemBuilder:
                        (context, index) => Image.file(
                          items.selectedItem!.images[index],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}
